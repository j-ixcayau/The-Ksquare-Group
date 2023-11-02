import 'package:flutter/material.dart';

import 'package:users/data_source/models/user.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(
          '${user.name}. AKA: ${user.userName}',
          maxLines: 1,
        ),
        subtitle: Text(
          user.email,
        ),
      ),
    );
  }
}
