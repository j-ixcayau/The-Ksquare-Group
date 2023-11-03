import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider_test/provider_test.dart';

import 'package:users/data_source/repository/user_repository.dart';
import 'package:users/presentation/features/users/provider/users_provider.dart';

import 'users_fakes.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group(
    'UsersProvider Test',
    () {
      late UsersProvider usersProvider;
      late MockUserRepository mockUserRepository;

      setUp(
        () {
          mockUserRepository = MockUserRepository();
          usersProvider = UsersProvider(repository: mockUserRepository);
        },
      );

      testProvider<UsersProvider>(
        'Valid non empty list',
        setUp: () {
          when(
            () => mockUserRepository.getUsers(),
          ).thenAnswer(
            (_) async => UserFakes.validList,
          );
        },
        build: () => usersProvider,
        seed: (bloc) {
          //
        },
        act: (bloc) => bloc.init(),
        verify: (bloc) {
          verify(() => mockUserRepository.getUsers()).called(1);

          expect(bloc.users, isNotNull);
          expect(bloc.users, isNotEmpty);
        },
      );

      testProvider<UsersProvider>(
        'Valid  empty list',
        setUp: () {
          when(
            () => mockUserRepository.getUsers(),
          ).thenAnswer(
            (_) async => UserFakes.emptyList,
          );
        },
        build: () => usersProvider,
        seed: (bloc) {
          //
        },
        act: (bloc) => bloc.init(),
        verify: (bloc) {
          verify(() => mockUserRepository.getUsers()).called(1);

          expect(bloc.users, isNotNull);
          expect(bloc.users, isEmpty);
        },
      );

      testProvider<UsersProvider>(
        'Handler null list',
        setUp: () {
          when(
            () => mockUserRepository.getUsers(),
          ).thenAnswer(
            (_) async => null,
          );
        },
        build: () => usersProvider,
        seed: (bloc) {
          //
        },
        act: (bloc) => bloc.init(),
        verify: (bloc) {
          verify(() => mockUserRepository.getUsers()).called(1);

          expect(bloc.users, isNull);
        },
      );
    },
  );
}
