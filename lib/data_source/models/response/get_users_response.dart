import 'package:test_interview/data_source/models/user.dart';

class GetUsersResponse {
  const GetUsersResponse({
    required this.users,
  });

  final List<User> users;

  factory GetUsersResponse.fromJson(List<dynamic> json) {
    final users = json.map((it) => User.fromJson(it)).toList();

    return GetUsersResponse(users: users);
  }
}
