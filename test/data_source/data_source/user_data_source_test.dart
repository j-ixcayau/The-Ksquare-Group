import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'package:users/data_source/data_source/user_data_source.dart';
import 'package:users/data_source/models/response/get_users_response.dart';

import 'user_data_source_fakes.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  group(
    'UserDataSource Test',
    () {
      late UserDataSourceImpl userDataSource;
      late MockHttpClient mockHttpClient;

      setUp(
        () {
          mockHttpClient = MockHttpClient();
          userDataSource = UserDataSourceImpl(httpClient: mockHttpClient);
        },
      );

      setUpAll(
        () {
          registerFallbackValue(Uri.parse(''));
        },
      );

      test(
        'Valid non empty list',
        () async {
          // Arrange
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => UserDataSourceFakes.validList,
          );

          // Act
          final getUsersResponse = await userDataSource.getUsers();

          // Assert
          expect(getUsersResponse, isA<GetUsersResponse>());
          expect(getUsersResponse.users.first.name, 'Leanne Graham');
        },
      );

      test(
        'Valid empty list',
        () async {
          // Arrange
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => UserDataSourceFakes.emptyList,
          );

          // Act
          final getUsersResponse = await userDataSource.getUsers();

          // Assert
          expect(getUsersResponse, isA<GetUsersResponse>());
          expect(getUsersResponse.users, isEmpty);
        },
      );

      test(
        'handler 500 response',
        () async {
          // Arrange
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => UserDataSourceFakes.noValidresponse,
          );

          // Act
          expect(() async => await userDataSource.getUsers(), throwsException);
        },
      );

      test(
        'handler 404 response',
        () async {
          // Arrange
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => UserDataSourceFakes.unknownResponse,
          );

          // Act
          expect(() async => await userDataSource.getUsers(), throwsException);
        },
      );
    },
  );
}
