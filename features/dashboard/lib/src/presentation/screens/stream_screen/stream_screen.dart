import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../dashboard.dart';
import 'bloc/stream_event.dart';
import 'bloc/stream_state.dart';

class StreamScreen extends StatefulWidget {
  final BlocNoParameter parameter;

  const StreamScreen({super.key, required this.parameter});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      bloc: Injector.container<StreamBloc>(),
      parameter: widget.parameter,
      child: const StreamScreenBody(),
    );
  }
}

class StreamScreenBody extends StatefulWidget {
  const StreamScreenBody({super.key});

  @override
  State<StreamScreenBody> createState() => _StreamScreenBodyState();
}

class _StreamScreenBodyState extends State<StreamScreenBody> {
  StreamBloc? _bloc;
  WebsocketBloc? _websocketBloc;
  int _maxLimit = 25;
  DisabledButton _disabledButton = DisabledButton.max25;

  @override
  void initState() {
    super.initState();
    _bloc = BaseScreen.of<StreamBloc>(context);
    _websocketBloc = SharedBlocProvider.of<WebsocketBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stream"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                Routes.settings,
                arguments: const SettingsBlocParameter(
                  previousPage: "Stream Screen",
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<WebsocketBloc, WebsocketState>(
            builder: (context, websocketState) {
          return BlocBuilder<StreamBloc, StreamState>(
              builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${context.strId.max_limit}: $_maxLimit"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: _disabledButton != DisabledButton.max25
                            ? () {
                                setState(() {
                                  _maxLimit = 25;
                                  _disabledButton = DisabledButton.max25;
                                });
                              }
                            : null,
                        child: const Text('25')),
                    TextButton(
                        onPressed: _disabledButton != DisabledButton.max50
                            ? () {
                                setState(() {
                                  _maxLimit = 50;
                                  _disabledButton = DisabledButton.max50;
                                });
                              }
                            : null,
                        child: const Text('50')),
                    TextButton(
                        onPressed: _disabledButton != DisabledButton.max100
                            ? () {
                                setState(() {
                                  _maxLimit = 100;
                                  _disabledButton = DisabledButton.max100;
                                });
                              }
                            : null,
                        child: const Text('100')),
                  ],
                ),
                StreamBuilder<String>(
                    stream: _websocketBloc?.numberStream,
                    builder: (context, snapshot) {
                      return Text(snapshot.data ?? "23");
                    }),
                TextButton(
                  onPressed: () {
                    _websocketBloc?.add(FetchNumberStreamEvent(
                      maxLimit: _maxLimit,
                    ));
                  },
                  child: const Text("TEXT"),
                ),
              ],
            );
          });
        }),
      ),
    );
  }
}
