import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:users/data_source/repository/user_repository.dart';
import 'package:users/di.dart';
import 'package:users/presentation/features/users/page/users_layout.dart';
import 'package:users/presentation/features/users/provider/users_provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UsersProvider(
        repository: sl.get<UserRepository>(),
      )..init(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          centerTitle: true,
        ),
        body: const UsersLayout(),
      ),
    );
  }
}
