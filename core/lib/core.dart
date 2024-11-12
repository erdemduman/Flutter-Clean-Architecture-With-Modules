library core;

// packages
export 'package:kiwi/kiwi.dart';
export 'package:logger/logger.dart';
export 'package:equatable/equatable.dart';
export 'package:collection/collection.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:bloc_concurrency/bloc_concurrency.dart';
export 'package:flutter_localizations/flutter_localizations.dart';

// constants
export 'src/constants/app_constants.dart';

// di
export 'src/di/injector.dart';

// l10n
export 'l10n/app_localizations.dart';

// build config
export 'src/build_config/build_config.dart';

// route
export 'src/route/routable.dart';
export 'src/route/routes.dart';
export 'src/route/route_mixin.dart';

// exception
export 'src/exception/random_number_exception.dart';

// model
export 'src/data/model/random_number_model.dart';

// mapper
export 'src/data/mapper/random_number_mapper.dart';

// repository
export 'src/domain/repository/random_number_repository.dart';
export 'src/data/repository/random_number_repository_impl.dart';

// data source
export 'src/data/data_source/random_number_data_source.dart';
export 'src/data/data_source/random_number_memory_data_source.dart';
export 'src/data/data_source/random_number_stream_data_source.dart';

// entity
export 'src/domain/entity/random_number_entity.dart';

// use case
export 'src/domain/use_case/use_case.dart';
export 'src/domain/use_case/use_case_parameter.dart';
export 'src/domain/use_case/get_random_number_stream_use_case.dart';
export 'src/domain/use_case/get_random_number_use_case.dart';
export 'src/domain/use_case/get_stored_random_number_use_case.dart';
export 'src/domain/use_case/stop_number_generation_use_case.dart';

// bloc
export 'src/presentation/bloc/base_bloc.dart';
export 'src/presentation/bloc/base_event.dart';
export 'src/presentation/bloc/base_state.dart';
export 'src/presentation/bloc/bloc_parameter.dart';
export 'src/presentation/bloc/websocket_bloc/websocket_bloc.dart';

export 'src/presentation/bloc/theme_bloc/theme_bloc.dart';
export 'src/presentation/bloc/theme_bloc/theme_event.dart';
export 'src/presentation/bloc/theme_bloc/theme_state.dart';

export 'src/presentation/bloc/language_bloc/language_bloc.dart';
export 'src/presentation/bloc/language_bloc/language_event.dart';
export 'src/presentation/bloc/language_bloc/language_state.dart';

// widgets
export 'src/presentation/widgets/base_screen.dart';
export 'src/presentation/widgets/parameter/settings_bloc_parameter.dart';
export 'src/presentation/widgets/shared_bloc_provider.dart';
export 'src/presentation/widgets/build_context_extension.dart';
