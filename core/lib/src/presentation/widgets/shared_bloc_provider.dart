import 'package:core/src/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:core/src/presentation/bloc/websocket_bloc/websocket_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injector.dart';
import '../bloc/base_bloc.dart';
import '../bloc/bloc_parameter.dart';
import '../bloc/theme_bloc/theme_bloc.dart';

class SharedBlocProvider extends StatefulWidget {
  final Widget child;
  final ThemeBloc themeBloc = Injector.resolve<ThemeBloc>();
  final LanguageBloc languageBloc = Injector.resolve<LanguageBloc>();
  final WebsocketBloc websocketBloc = Injector.resolve<WebsocketBloc>();

  SharedBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  static T? of<T extends BaseBloc>(BuildContext context) {
    final SharedBlocProvider? provider =
        context.findAncestorWidgetOfExactType();

    if (T == ThemeBloc) {
      return provider?.themeBloc as T;
    } else if (T == LanguageBloc) {
      return provider?.languageBloc as T;
    } else if (T == WebsocketBloc) {
      return provider?.websocketBloc as T;
    }
    return null;
  }

  @override
  State createState() => _SharedBlocProviderPocState();
}

class _SharedBlocProviderPocState extends State<SharedBlocProvider>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    widget.themeBloc.init(parameter: const BlocNoParameter());
    widget.languageBloc.init(parameter: const BlocNoParameter());
    widget.websocketBloc.init(parameter: const BlocNoParameter());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.themeBloc),
        BlocProvider.value(value: widget.languageBloc),
        BlocProvider.value(value: widget.websocketBloc),
      ],
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.themeBloc.dispose();
    widget.themeBloc.close();

    widget.languageBloc.dispose();
    widget.languageBloc.close();

    widget.websocketBloc.dispose();
    widget.websocketBloc.close();

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
