import 'dart:math';
import 'package:core/core.dart';
import 'package:dashboard/dashboard.dart';
import 'package:settings/settings.dart';

class InitDependencyInjection {
  static void init(BuildConfig config) {
    //Other
    Injector.registerSingleton((c) => Logger());
    Injector.registerSingleton<BuildConfig>((c) => config);
    Injector.registerFactory<Random>((c) => Random());

    // Data Source
    Injector.registerSingleton<RandomNumberDataSource>(
      (c) => RandomNumberDataSourceImpl(
        c<Random>(),
        c<Logger>(),
      ),
    );
    Injector.registerSingleton<RandomNumberStreamDataSource>(
      (c) => RandomNumberStreamDataSourceImpl(
        c<Random>(),
        c<Logger>(),
      ),
    );
    Injector.registerSingleton<RandomNumberMemoryDataSource>(
      (c) => RandomNumberMemoryDataSourceImpl(),
    );

    // Repository
    Injector.registerSingleton<RandomNumberRepository>(
      (c) => RandomNumberRepositoryImpl(
        c<RandomNumberDataSource>(),
        c<RandomNumberStreamDataSource>(),
        c<RandomNumberMemoryDataSource>(),
      ),
    );

    // UseCase
    Injector.registerSingleton(
      (c) => GetRandomNumberUseCase(
        c<RandomNumberRepository>(),
      ),
    );
    Injector.registerSingleton(
      (c) => GetRandomNumberStreamUseCase(
        c<RandomNumberRepository>(),
      ),
    );
    Injector.registerSingleton(
      (c) => GetStoredRandomNumberUseCase(
        c<RandomNumberRepository>(),
      ),
    );
    Injector.registerSingleton(
      (c) => StopNumberGenerationUseCase(
        c<RandomNumberRepository>(),
      ),
    );

    // Bloc
    Injector.registerFactory((c) => MainBloc(c<Logger>()));
    Injector.registerFactory(
      (c) => NumberBloc(
        c<GetStoredRandomNumberUseCase>(),
        c<GetRandomNumberUseCase>(),
        c<Logger>(),
      ),
    );
    Injector.registerFactory(
      (c) => StreamBloc(
        c<GetStoredRandomNumberUseCase>(),
        c<Logger>(),
      ),
    );
    Injector.registerFactory(
      (c) => SettingsBloc(
        c<Logger>(),
      ),
    );
    Injector.registerFactory(
      (c) => SecretStreamBloc(
        c<Logger>(),
      ),
    );
    Injector.registerFactory((c) => ThemeBloc(c<Logger>()));
    Injector.registerFactory((c) => LanguageBloc(c<Logger>()));
  }
}
