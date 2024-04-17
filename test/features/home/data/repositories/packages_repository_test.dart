import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navi_stream/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:navi_stream/features/home/data/data_sources/packages_remote_data_source.dart';
import 'package:navi_stream/features/home/data/repositories/packages_repository.dart';

class MockPackagesRemoteDioDataSource extends Mock
    implements PackagesRemoteDioDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late PackagesRepository packagesRepository;
  late PackagesRemoteDioDataSource packagesRemoteDioDataSource;
  late AuthLocalDataSource authLocalDataSource;

  setUp(
    () {
      packagesRemoteDioDataSource = MockPackagesRemoteDioDataSource();
      authLocalDataSource = MockAuthLocalDataSource();
      packagesRepository = PackagesRepository(
        packagesRemoteDioDataSource,
        authLocalDataSource,
      );
    },
  );
  group(
    'success',
    () {
      test(
        'should returns purchased packages on success',
        () async {
          when(() => authLocalDataSource.getToken()).thenAnswer(
            (_) async => 'token',
          );
          when(() => authLocalDataSource.getOuid()).thenAnswer(
            (_) async => 'ouid',
          );
          when(() => authLocalDataSource.getUserId()).thenAnswer(
            (_) async => 1,
          );
          when(() => packagesRemoteDioDataSource.fetchPackages(
              any(), any(), any(), any())).thenAnswer(
            (_) async => {
              'data': [],
            },
          );

          expect(
            await packagesRepository.fetchPackages(),
            [],
          );
        },
      );
    },
  );
  group(
    'failure',
    () {
      test(
        'should throw exception on failure',
        () async {
          when(() => authLocalDataSource.getToken()).thenAnswer(
            (_) async => 'token',
          );
          when(() => authLocalDataSource.getOuid()).thenAnswer(
            (_) async => 'ouid',
          );
          when(() => authLocalDataSource.getUserId()).thenAnswer(
            (_) async => 1,
          );
          when(
            () => packagesRemoteDioDataSource.fetchPackages(
              any(),
              any(),
              any(),
              any(),
            ),
          ).thenThrow(
            Exception(
              'Failed to fetch packages',
            ),
          );

          expect(() async => await packagesRepository.fetchPackages(),
              throwsException);
        },
      );
    },
  );
}
