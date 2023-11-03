import 'package:flutter/widgets.dart';

import 'package:users/data_source/models/user.dart';
import 'package:users/data_source/repository/user_repository.dart';

class UsersProvider extends ChangeNotifier {
  UsersProvider({
    required UserRepository repository,
  }) : _repository = repository;

  final UserRepository _repository;

  List<User>? users;

  void init() async {
    final result = await _repository.getUsers();

    users = result?.users;
    notifyListeners();
  }
}
