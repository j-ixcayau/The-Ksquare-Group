import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import 'package:users/data_source/data_source/user_data_source.dart';
import 'package:users/data_source/repository/user_repository.dart';

final sl = GetIt.instance;

class DI {
  DI._();

  static void init() {
    sl.registerLazySingleton<Client>(
      () => Client(),
    );

    sl.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(
        httpClient: sl(),
      ),
    );

    sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        dataSource: sl(),
      ),
    );
  }
}
