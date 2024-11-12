import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/src/presentation/secret_stream_screen/bloc/secret_stream_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
