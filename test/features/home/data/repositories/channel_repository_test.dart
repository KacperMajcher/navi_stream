import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:navi_stream/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:navi_stream/features/home/data/data_sources/channels_remote_data_source.dart';
import 'package:navi_stream/features/home/data/models/channel_dto.dart';
import 'package:navi_stream/features/home/data/models/channel_model.dart';
import 'package:navi_stream/features/home/data/models/channel_response.dart';
import 'package:navi_stream/features/home/data/repositories/channel_repository.dart';

class MockChannelsRemoteDataSource extends Mock
    implements ChannelsRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late ChannelsRepository sut;
  late MockChannelsRemoteDataSource remoteDataSource;
  late MockAuthLocalDataSource localDataSource;
  final packageIds = [1, 2, 3];

  setUp(
    () {
      remoteDataSource = MockChannelsRemoteDataSource();
      localDataSource = MockAuthLocalDataSource();
      sut = ChannelsRepository(
        remoteDataSource,
        localDataSource,
      );
    },
  );
  group(
    'success',
    () {
      test(
        'should return list of ChannelModels when fetch is successful',
        () async {
          when(
            () => localDataSource.getToken(),
          ).thenAnswer(
            (_) async => 'token',
          );
          when(
            () => localDataSource.getOuid(),
          ).thenAnswer(
            (_) async => 'ouid',
          );

          final response = HttpResponse(
            ChannelResponse(
              data: [
                ChannelDTO(
                  id: 1,
                  name: 'channel1',
                ),
              ],
            ),
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
            ),
          );

          when(
            () => remoteDataSource.fetchChannels(any(), any(), any()),
          ).thenAnswer(
            (_) async => response,
          );

          final result = await sut.getChannelModels(
            packageIds: packageIds,
          );

          expect(result, isA<List<ChannelModel>>());
          expect(result.length, 1);
        },
      );
    },
  );
  group(
    'failure',
    () {
      group(
        'unauthorized access',
        () {
          test(
            'should throw exception when unauthorized access (401 error)',
            () async {
              when(
                () => localDataSource.getToken(),
              ).thenAnswer(
                (_) async => 'invalid_token',
              );
              when(
                () => localDataSource.getOuid(),
              ).thenAnswer(
                (_) async => 'invalid_ouid',
              );

              final response = Response<Map<String, dynamic>>(
                requestOptions: RequestOptions(),
                statusCode: 401,
                data: {
                  'message': 'Unauthorized access',
                },
              );
              final httpResponse = HttpResponse<ChannelResponse>(
                const ChannelResponse(data: []),
                response,
              );

              when(
                () => remoteDataSource.fetchChannels(any(), any(), any()),
              ).thenAnswer(
                (_) async => httpResponse,
              );

              expect(
                sut.getChannelModels(packageIds: packageIds),
                throwsException,
              );
            },
          );
        },
      );

      group(
        'DioException',
        () {
          test(
            'should throw exception when there is a DioException',
            () async {
              when(
                () => localDataSource.getToken(),
              ).thenThrow(
                DioException(
                  requestOptions: RequestOptions(),
                  error: 'Connection failed',
                ),
              );

              when(
                () => remoteDataSource.fetchChannels(any(), any(), any()),
              ).thenThrow(
                DioException(
                  requestOptions: RequestOptions(),
                  error: 'Connection failed',
                ),
              );

              expect(
                () => sut.getChannelModels(
                  packageIds: packageIds,
                ),
                throwsException,
              );
            },
          );

          group(
            'DioException with response',
            () {
              test(
                'should handle DioException with response error data',
                () async {
                  final requestOptions = RequestOptions();
                  when(
                    () => localDataSource.getToken(),
                  ).thenAnswer(
                    (_) async => 'token',
                  );
                  when(
                    () => localDataSource.getOuid(),
                  ).thenAnswer(
                    (_) async => 'ouid',
                  );

                  final errorResponse = Response(
                    requestOptions: requestOptions,
                    statusCode: 404,
                    data: {
                      'error': 'Not Found',
                    },
                  );
                  when(
                    () => remoteDataSource.fetchChannels(any(), any(), any()),
                  ).thenThrow(
                    DioException(
                      requestOptions: requestOptions,
                      response: errorResponse,
                      error: 'Not Found',
                    ),
                  );

                  expect(
                    () => sut.getChannelModels(
                      packageIds: packageIds,
                    ),
                    throwsA(
                      isA<Exception>().having(
                        (e) => e.toString(),
                        'message',
                        contains(
                          'Error: 404 {error: Not Found}',
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      );
      group(
        'Other Errors',
        () {
          test(
            'should throw an exception for other error status codes',
            () async {
              when(
                () => localDataSource.getToken(),
              ).thenAnswer((_) async => 'token');
              when(
                () => localDataSource.getOuid(),
              ).thenAnswer(
                (_) async => 'ouid',
              );

              final response = Response<Map<String, dynamic>>(
                requestOptions: RequestOptions(),
                statusCode: 500,
                data: {
                  'message': 'Internal server error',
                },
              );
              final httpResponse = HttpResponse<ChannelResponse>(
                const ChannelResponse(data: []),
                response,
              );

              when(
                () => remoteDataSource.fetchChannels(any(), any(), any()),
              ).thenAnswer((_) async => httpResponse);

              expect(
                sut.getChannelModels(
                  packageIds: packageIds,
                ),
                throwsA(
                  isA<Exception>().having(
                    (e) => e.toString(),
                    'message',
                    contains(
                      'Error fetching data. Status code: 500',
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}
