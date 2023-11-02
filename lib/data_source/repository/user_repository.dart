import 'package:users/data_source/data_source/user_data_source.dart';
import 'package:users/data_source/models/response/get_users_response.dart';

abstract class UserRepository {
  Future<GetUsersResponse?> getUsers();
}

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required UserDataSource dataSource,
  }) : _dataSource = dataSource;

  final UserDataSource _dataSource;

  @override
  Future<GetUsersResponse?> getUsers() async {
    try {
      return await _dataSource.getUsers();
    } catch (e) {
      print(e);
    }

    return null;
  }
}
