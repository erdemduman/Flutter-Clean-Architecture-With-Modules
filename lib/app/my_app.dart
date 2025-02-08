import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch/app/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => Injector.resolve<ThemeBloc>()),
        BlocProvider(create: (context) => Injector.resolve<LanguageBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) =>
            BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, languageState) => MaterialApp(
            title: 'Modular Clean Architecture',
            initialRoute: Routes.main,
            onGenerateRoute: AppRouter.generateRoute,
            theme:
                themeState.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('de'),
              Locale('tr'),
            ],
            locale: Locale.fromSubtags(
              languageCode: languageState.language,
            ),
          ),
        ),
      ),
    );
  }
}
