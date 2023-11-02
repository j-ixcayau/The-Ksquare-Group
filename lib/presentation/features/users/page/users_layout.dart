import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:test_interview/presentation/features/users/provider/users_provider.dart';

class UsersLayout extends StatelessWidget {
  const UsersLayout({super.key});

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
          itemCount: model.users!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                model.users![index].name,
              ),
            );
          },
        );
      },
    );
  }
}
