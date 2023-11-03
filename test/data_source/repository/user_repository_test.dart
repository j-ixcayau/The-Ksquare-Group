import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:users/data_source/data_source/user_data_source.dart';
import 'package:users/data_source/models/response/get_users_response.dart';
import 'package:users/data_source/repository/user_repository.dart';

import 'user_repository_fakes.dart';

class MockUserDataSource extends Mock implements UserDataSource {}

void main() {
  group(
    'UserRepository Test',
    () {
      late UserRepositoryImpl userRepository;
      late MockUserDataSource mockUserDataSource;

      setUp(
        () {
          mockUserDataSource = MockUserDataSource();
          userRepository = UserRepositoryImpl(
            dataSource: mockUserDataSource,
          );
        },
      );

      test(
        'Valid non empty list',
        () async {
          // Arrange
          when(
            () => mockUserDataSource.getUsers(),
          ).thenAnswer(
            (_) async => UserRepositoryFakes.validList,
          );

          // Act
          final getUsersResponse = await userRepository.getUsers();

          // Assert
          expect(getUsersResponse, isA<GetUsersResponse>());
          expect(getUsersResponse?.users, isNotNull);

          getUsersResponse!.users;
          expect(getUsersResponse.users, isNotEmpty);
          expect(getUsersResponse.users.first.name, 'Leanne Graham');
        },
      );

      test(
        'Valid empty list',
        () async {
          // Arrange
          when(
            () => mockUserDataSource.getUsers(),
          ).thenAnswer(
            (_) async => UserRepositoryFakes.emptyList,
          );

          // Act
          final getUsersResponse = await userRepository.getUsers();

          // Assert
          expect(getUsersResponse, isNotNull);
          expect(getUsersResponse?.users, isNotNull);
          expect(getUsersResponse!.users, isEmpty);
        },
      );

      test(
        'Handler exception',
        () async {
          // Arrange
          when(
            () => mockUserDataSource.getUsers(),
          ).thenThrow(
            (_) async => Exception(),
          );

          // Act
          final getUsersResponse = await userRepository.getUsers();

          // Assert
          expect(getUsersResponse, isNull);
        },
      );
    },
  );
}
