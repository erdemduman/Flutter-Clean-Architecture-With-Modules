import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_event.dart';
import 'base_state.dart';

/// Abstract class to be extended by Blocs.
///
/// State classes of Blocs will be passed as a type argument that extends
/// [BaseState].
abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  BaseBloc(S initialState) : super(initialState);
}
