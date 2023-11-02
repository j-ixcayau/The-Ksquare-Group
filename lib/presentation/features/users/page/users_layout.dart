import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:users/presentation/features/users/provider/users_provider.dart';
import 'package:users/presentation/features/users/widgets/user_item.dart';

class UsersLayout extends StatelessWidget {
  const UsersLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (context, model, _) {
        if (model.users == null) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: model.users!.length,
          itemBuilder: (context, index) {
            return UserItem(
              user: model.users![index],
            );
          },
        );
      },
    );
  }
}
