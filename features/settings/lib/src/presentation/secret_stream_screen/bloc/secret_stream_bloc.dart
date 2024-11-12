import 'package:core/core.dart';
import 'package:settings/src/presentation/secret_stream_screen/bloc/secret_stream_event.dart';
import 'package:settings/src/presentation/secret_stream_screen/bloc/secret_stream_state.dart';

class SecretStreamBloc extends BaseBloc<SecretStreamEvent, SecretStreamState> {
  final Logger _logger;

  SecretStreamBloc(this._logger) : super(SecretStreamState.create()) {}

  @override
  void init({required BlocParameter parameter}) {
    _logger.d("Init");
  }

  @override
  void dispose() {
    _logger.d("Dispose");
  }
}
