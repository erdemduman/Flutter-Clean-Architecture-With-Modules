import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:settings/src/presentation/settings_screen/bloc/settings_state.dart';

import 'bloc/settings_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector.resolve<SettingsBloc>(),
      child: const SettingsScreenBody(),
    );
  }
}

class SettingsScreenBody extends StatefulWidget {
  const SettingsScreenBody({super.key});

  @override
  State<SettingsScreenBody> createState() => _SettingsScreenBodyState();
}

class _SettingsScreenBodyState extends State<SettingsScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(context.strId.light_theme),
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, themeState) => Switch(
                      value: themeState.isDarkTheme,
                      onChanged: (_) {
                        context.read<ThemeBloc>().add(ToggleThemeEvent());
                      },
                    ),
                  ),
                  Text(context.strId.dark_theme),
                ],
              ),
              BlocBuilder<LanguageBloc, LanguageState>(
                  builder: (context, languageState) {
                return DropdownButton<String>(
                  value: languageState.language,
                  items: [AppConstants.en, AppConstants.de, AppConstants.tr]
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(_getLanguageName(context, item)),
                        ),
                      )
                      .toList(),
                  onChanged: (lang) {
                    context.read<LanguageBloc>().add(
                          ChangeLanguageEvent(language: lang ?? ""),
                        );
                  },
                );
              }),
            ],
          ),
        );
      }),
    );
  }

  String _getLanguageName(BuildContext context, String lang) {
    switch (lang) {
      case AppConstants.en:
        return context.strId.en;
      case AppConstants.de:
        return context.strId.de;
      case AppConstants.tr:
        return context.strId.tr;
      default:
        return context.strId.en;
    }
  }
}
