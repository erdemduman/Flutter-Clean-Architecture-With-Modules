import 'package:core/src/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injector.dart';
import '../bloc/base_bloc.dart';
import '../bloc/theme_bloc/theme_bloc.dart';

class SharedBlocProvider extends StatefulWidget {
  final Widget child;
  final ThemeBloc themeBloc = Injector.resolve<ThemeBloc>();
  final LanguageBloc languageBloc = Injector.resolve<LanguageBloc>();

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
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.themeBloc),
        BlocProvider.value(value: widget.languageBloc),
      ],
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.themeBloc.close();
    widget.languageBloc.close();

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
