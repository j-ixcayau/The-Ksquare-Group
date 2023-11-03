import 'package:users/data_source/models/response/get_users_response.dart';
import 'package:users/data_source/models/user.dart';

class UserFakes {
  UserFakes._();

  static GetUsersResponse validList = const GetUsersResponse(
    users: [
      User(
        name: 'Leanne Graham',
        userName: 'Bret',
        email: 'Sincere@april.biz',
      ),
    ],
  );

  static GetUsersResponse emptyList = const GetUsersResponse(
    users: [],
  );
}
