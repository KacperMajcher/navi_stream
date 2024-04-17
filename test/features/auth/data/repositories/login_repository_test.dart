import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:navi_stream/features/auth/data/data_source/login_remote_data_source.dart';
import 'package:navi_stream/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:navi_stream/features/auth/data/models/login_model.dart';
import 'package:navi_stream/features/auth/data/repositories/login_repository.dart';

class MockLoginRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockResponse extends Mock implements Response {}

void main() {
  late LoginRepository sut;
  late MockLoginRemoteDataSource remoteDataSource;
  late MockAuthLocalDataSource localDataSource;
  late Response mockResponse;
  late LoginModel loginModel;

  setUp(
    () {
      remoteDataSource = MockLoginRemoteDataSource();
      localDataSource = MockAuthLocalDataSource();
      sut = LoginRepository(
        remoteDataSource,
        localDataSource,
      );
      mockResponse = MockResponse();
      loginModel = const LoginModel(
          username: 'test',
          password: 'password',
          loginType: 'loginType',
          device: 'device');
    },
  );

  group(
    'LoginRepository tests',
    () {
      group(
        'success',
        () {
          test(
            'should save token, ouid, and userId on successful login',
            () async {
              when(
                () => remoteDataSource.login(
                  loginModel,
                ),
              ).thenAnswer(
                (_) async => mockResponse,
              );
              when(() => mockResponse.statusCode).thenReturn(
                200,
              );
              when(() => mockResponse.data).thenReturn(
                {
                  'data': {
                    'access_token': 'token123',
                    'operator_uid': 'ouid123',
                    'user_id': 1
                  }
                },
              );

              when(
                () => localDataSource.setToken(
                  any(),
                ),
              ).thenAnswer((_) async => true);
              when(
                () => localDataSource.setOuid(
                  any(),
                ),
              ).thenAnswer((_) async => true);
              when(
                () => localDataSource.setUserId(
                  any(),
                ),
              ).thenAnswer((_) async => true);

              final response = await sut.login(loginModel);

              verify(
                () => remoteDataSource.login(
                  loginModel,
                ),
              ).called(1);
              verify(
                () => localDataSource.setToken(
                  any(),
                ),
              ).called(1);
              verify(
                () => localDataSource.setOuid(
                  any(),
                ),
              ).called(1);
              verify(
                () => localDataSource.setUserId(
                  any(),
                ),
              ).called(1);
              expect(
                response.statusCode,
                200,
              );
            },
          );
          group(
            'failure',
            () {
              test(
                'should throw an exception on unauthorized access',
                () async {
                  when(
                    () => remoteDataSource.login(
                      loginModel,
                    ),
                  ).thenAnswer(
                    (_) async => mockResponse,
                  );
                  when(() => mockResponse.statusCode).thenReturn(
                    401,
                  );

                  expect(
                    () async => await sut.login(loginModel),
                    throwsException,
                  );
                },
              );

              test(
                'should handle DioException',
                () async {
                  final dioError = DioException(
                    requestOptions: RequestOptions(),
                    error: 'Failed to connect to the server',
                  );
                  when(
                    () => remoteDataSource.login(
                      loginModel,
                    ),
                  ).thenThrow(
                    dioError,
                  );

                  expect(
                    () async => await sut.login(
                      loginModel,
                    ),
                    throwsException,
                  );
                },
              );

              test(
                'should generate correct error message for DioError with non-null response',
                () async {
                  final dioError = DioException(
                    requestOptions: RequestOptions(),
                    response: Response(
                      requestOptions: RequestOptions(),
                      statusCode: 404,
                      data: "Not Found",
                    ),
                    error: 'Error occurred',
                  );
                  when(
                    () => remoteDataSource.login(
                      loginModel,
                    ),
                  ).thenThrow(
                    dioError,
                  );

                  try {
                    await sut.login(
                      loginModel,
                    );
                  } catch (e) {
                    expect(
                      e.toString(),
                      contains(
                        'Error: 404 Not Found',
                      ),
                    );
                  }
                },
              );

              test(
                'should throw the correct exception on unexpected status code',
                () async {
                  when(
                    () => remoteDataSource.login(
                      loginModel,
                    ),
                  ).thenAnswer(
                    (_) async => mockResponse,
                  );
                  when(
                    () => mockResponse.statusCode,
                  ).thenReturn(500);

                  expect(
                    () async => await sut.login(
                      loginModel,
                    ),
                    throwsException,
                  );
                  try {
                    await sut.login(
                      loginModel,
                    );
                  } catch (e) {
                    expect(
                      e.toString(),
                      contains(
                        'Error fetching data. Status code: 500',
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      );
    },
  );
}
