import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:users/data_source/data_source/user_data_source.dart';
import 'package:users/data_source/models/response/get_users_response.dart';

import 'user_data_source_fakes.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group(
    'UserDataSourceImpl',
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
        'getUsers should return a GetUsersResponse',
        () async {
          // Arrange
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => http.Response(
              UserDataSourceFakes.usersJson,
              200,
            ),
          );

          // Act
          final getUsersResponse = await userDataSource.getUsers();

          // Assert
          expect(getUsersResponse, isA<GetUsersResponse>());
          expect(getUsersResponse.users.first.name, 'Leanne Graham');
        },
      );

      test(
        'getUsers should throw an exception if the request fails',
        () async {
          // Arrange
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => http.Response('Something went wrong', 500),
          );

          // Act
          expect(() async => await userDataSource.getUsers(), throwsException);
        },
      );
    },
  );
}
