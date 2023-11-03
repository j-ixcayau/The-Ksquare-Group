import 'dart:convert';

import 'package:http/http.dart';

import 'package:users/data_source/models/response/get_users_response.dart';

abstract class UserDataSource {
  Future<GetUsersResponse> getUsers();
}

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl({
    Client? httpClient,
  }) : _httpClient = httpClient ?? Client();

  final String url = 'https://jsonplaceholder.typicode.com/users';
  final Client _httpClient;

  @override
  Future<GetUsersResponse> getUsers() async {
    final uri = Uri.parse(url);
    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception();
    }

    final body = jsonDecode(response.body);

    return GetUsersResponse.fromJson(body);
  }
}
