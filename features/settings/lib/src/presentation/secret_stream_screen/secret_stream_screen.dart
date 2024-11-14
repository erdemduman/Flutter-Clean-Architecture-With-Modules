import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/src/presentation/secret_stream_screen/bloc/secret_stream_bloc.dart';
import 'package:settings/src/presentation/secret_stream_screen/bloc/secret_stream_state.dart';

class SecretStreamScreen extends StatefulWidget {
  final BlocNoParameter parameter;

  const SecretStreamScreen({super.key, required this.parameter});

  @override
  State<SecretStreamScreen> createState() => _SecretStreamScreenState();
}

class _SecretStreamScreenState extends State<SecretStreamScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      bloc: Injector.resolve<SecretStreamBloc>(),
      parameter: widget.parameter,
      child: const SecretStreamScreenBody(),
    );
  }
}

class SecretStreamScreenBody extends StatefulWidget {
  const SecretStreamScreenBody({super.key});

  @override
  State<SecretStreamScreenBody> createState() => _SecretStreamScreenBodyState();
}

class _SecretStreamScreenBodyState extends State<SecretStreamScreenBody> {
  SecretStreamBloc? _bloc;
  WebsocketBloc? _websocketBloc;

  @override
  void initState() {
    super.initState();
    _bloc = BaseScreen.of<SecretStreamBloc>(context);
    _websocketBloc = SharedBlocProvider.of<WebsocketBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TOP SECRET"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocBuilder<SecretStreamBloc, SecretStreamState>(
          builder: (context, state) {
        return BlocBuilder<WebsocketBloc, WebsocketState>(
            builder: (context, websocketState) {
          return Center(
            child: Column(
              children: [
                StreamBuilder<String>(
                    stream: _websocketBloc?.numberStream,
                    builder: (context, snapshot) {
                      return Text("Here is the data: ${snapshot.data}");
                    }),
                TextButton(
                    onPressed: () {
                      _websocketBloc?.add(const StopNumberStreamEvent());
                    },
                    child: Text("STOp"))
              ],
            ),
          );
        });
      }),
    );
  }
}
