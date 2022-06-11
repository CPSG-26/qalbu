import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:qalbu/data/datasources/quran_remote_data_source.dart';
import 'package:qalbu/data/repositories/quran_repository_impl.dart';
import 'package:qalbu/domain/repositories/quran_repository.dart';
import 'package:qalbu/domain/usecases/get_quran_detail.dart';
import 'package:qalbu/domain/usecases/get_quran_list.dart';
import 'package:qalbu/presentation/bloc/quran/quran_bloc.dart';
import 'package:qalbu/presentation/bloc/quran_detail/quran_detail_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => QuranBloc(locator()));
  locator.registerFactory(() => QuranDetailBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetQuranList(locator()));
  locator.registerLazySingleton(() => GetQuranDetail(locator()));

  // repository
  locator.registerLazySingleton<QuranRepository>(
      () => QuranRepositoryImpl(remoteDataSource: locator()));

  // data sources
  locator.registerLazySingleton<QuranRemoteDataSource>(
      () => QuranRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
