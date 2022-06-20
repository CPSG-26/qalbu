import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:qalbu/data/datasources/doa_local_data_source.dart';
import 'package:qalbu/data/datasources/doa_remote_data_source.dart';
import 'package:qalbu/data/datasources/prayer_time_remote_data_source.dart';
import 'package:qalbu/data/datasources/quran_remote_data_source.dart';
import 'package:qalbu/data/db/doa_database_helper.dart';
import 'package:qalbu/data/repositories/doa_repository_impl.dart';
import 'package:qalbu/data/repositories/prayer_time_repository_impl.dart';
import 'package:qalbu/data/repositories/quran_repository_impl.dart';
import 'package:qalbu/domain/repositories/doa_repository.dart';
import 'package:qalbu/domain/repositories/prayer_time_repository.dart';
import 'package:qalbu/domain/repositories/quran_repository.dart';
import 'package:qalbu/domain/usecases/get_doa_detail.dart';
import 'package:qalbu/domain/usecases/get_doa_list.dart';
import 'package:qalbu/domain/usecases/get_favorite_doa.dart';
import 'package:qalbu/domain/usecases/get_favorite_status_doa.dart';
import 'package:qalbu/domain/usecases/get_prayer_time_daily.dart';
import 'package:qalbu/domain/usecases/get_prayer_time_monthly.dart';
import 'package:qalbu/domain/usecases/get_quran_detail.dart';
import 'package:qalbu/domain/usecases/get_quran_list.dart';
import 'package:qalbu/domain/usecases/remove_favorite_doa.dart';
import 'package:qalbu/domain/usecases/save_favorite_doa.dart';
import 'package:qalbu/presentation/bloc/doa_detail/doa_detail_bloc.dart';
import 'package:qalbu/presentation/bloc/doa_list/doa_list_bloc.dart';
import 'package:qalbu/presentation/bloc/favorite_doa/favorite_doa_bloc.dart';
import 'package:qalbu/presentation/bloc/prayer_time_daily/prayer_time_daily_bloc.dart';
import 'package:qalbu/presentation/bloc/prayer_time_monthly/prayer_time_monthly_bloc.dart';
import 'package:qalbu/presentation/bloc/quran/quran_bloc.dart';
import 'package:qalbu/presentation/bloc/quran_detail/quran_detail_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => QuranBloc(locator()));
  locator.registerFactory(() => QuranDetailBloc(locator()));
  locator.registerFactory(() => DoaListBloc(locator()));
  locator.registerFactory(() => DoaDetailBloc(locator()));
  locator.registerFactory(() => FavoriteDoaBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => PrayerTimeMonthlyBloc(locator()));
  locator.registerFactory(() => PrayerTimeDailyBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetQuranList(locator()));
  locator.registerLazySingleton(() => GetQuranDetail(locator()));
  locator.registerLazySingleton(() => GetDoaList(locator()));
  locator.registerLazySingleton(() => GetDoaDetail(locator()));
  locator.registerLazySingleton(() => GetFavoriteDoa(locator()));
  locator.registerLazySingleton(() => GetFavoriteStatusDoa(locator()));
  locator.registerLazySingleton(() => SaveFavoriteDoa(locator()));
  locator.registerLazySingleton(() => RemoveFavoriteDoa(locator()));
  locator.registerLazySingleton(() => GetPrayerTimeMonthly(locator()));
  locator.registerLazySingleton(() => GetPrayerTimeDaily(locator()));

  // repository
  locator.registerLazySingleton<QuranRepository>(
      () => QuranRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<DoaRepository>(
    () => DoaRepositoryImpl(
      doaRemoteDataSource: locator(),
      doaLocalDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<PrayerTimeRepository>(
      () => PrayerTimeRepositoryImpl(remoteDataSource: locator()));

  // data sources
  locator.registerLazySingleton<QuranRemoteDataSource>(
      () => QuranRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<DoaRemoteDataSource>(
      () => RemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<DoaLocalDataSource>(
      () => DoaLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<PrayerTimeRemoteDataSource>(
      () => PrayerTimeRemoteDataSourceImpl(client: locator()));

  // db
  locator.registerLazySingleton<DoaDatabaseHelper>(() => DoaDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
