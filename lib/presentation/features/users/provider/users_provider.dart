import 'package:flutter/widgets.dart';

import 'package:test_interview/data_source/models/user.dart';
import 'package:test_interview/data_source/repository/user_repository.dart';

class UsersProvider extends ChangeNotifier {
  UsersProvider({
    required UserRepository repository,
  }) : _repository = repository {
    _init();
  }

  final UserRepository _repository;

  List<User>? users;

  void _init() async {
    final result = await _repository.getUsers();

    users = result?.users;
    notifyListeners();
  }
}
