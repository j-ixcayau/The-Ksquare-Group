import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:test_interview/data_source/models/response/get_users_response.dart';

abstract class UserDataSource {
  Future<GetUsersResponse> getUsers();
}

class UserDataSourceImpl implements UserDataSource {
  final url = 'https://jsonplaceholder.typicode.com/users';

  @override
  Future<GetUsersResponse> getUsers() async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception();
    }

    final body = jsonDecode(response.body);

    return GetUsersResponse.fromJson(body);
  }
}
