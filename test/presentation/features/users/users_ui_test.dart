import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:users/data_source/repository/user_repository.dart';
import 'package:users/presentation/features/users/page/users_page.dart';
import 'package:users/presentation/features/users/widgets/user_item.dart';

import 'users_fakes.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(
    'UsersPage Test',
    () {
      late MockUserRepository mockUserRepository;

      setUp(
        () {
          mockUserRepository = MockUserRepository();
        },
      );

      testWidgets(
        'Progress Indicator for empty list',
        (tester) async {
          // When
          when(
            () => mockUserRepository.getUsers(),
          ).thenAnswer(
            (_) async => null,
          );

          // Creation/Render of Widget
          await _buildUI(tester, mockUserRepository);

          // Then
          final scaffold = find.byType(Scaffold);
          final circularProgress = find.byType(CircularProgressIndicator);

          // Expect
          expect(scaffold, findsOneWidget);
          expect(circularProgress, findsOneWidget);
        },
      );

      testWidgets(
        'List of items for non empty list',
        (tester) async {
          // When
          when(
            () => mockUserRepository.getUsers(),
          ).thenAnswer(
            (_) async => UserFakes.validList,
          );

          // Creation/Render of Widget
          await _buildUI(tester, mockUserRepository);

          // Then
          final scaffold = find.byType(Scaffold);
          final listViewBuilder = find.byType(ListView);
          final userItems = find.byType(UserItem);

          // Expect
          expect(scaffold, findsOneWidget);
          expect(listViewBuilder, findsOneWidget);
          expect(userItems, findsWidgets);
        },
      );

      testWidgets(
        'List of items for empty list',
        (tester) async {
          // When
          when(
            () => mockUserRepository.getUsers(),
          ).thenAnswer(
            (_) async => UserFakes.emptyList,
          );

          // Creation/Render of Widget
          await _buildUI(tester, mockUserRepository);

          // Then
          final scaffold = find.byType(Scaffold);
          final listViewBuilder = find.byType(ListView);
          final userItems = find.byType(UserItem);

          // Expect
          expect(scaffold, findsOneWidget);
          expect(listViewBuilder, findsOneWidget);
          expect(userItems, findsNothing);
        },
      );

      // Helper method
    },
  );
}

Future<void> _buildUI(
  WidgetTester tester,
  UserRepository mockUserRepository,
) async {
  tester.view.physicalSize = const Size(1080, 2220);
  tester.view.devicePixelRatio = 1.0;

  await tester.pumpWidget(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: UsersPage(
        repository: mockUserRepository,
      ),
    ),
  );

  await tester.pump();
}
