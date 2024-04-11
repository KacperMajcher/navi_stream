import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navi_stream/features/home/data/data_sources/packages_remote_data_source.dart';
import 'package:navi_stream/features/home/data/repositories/packages_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockPackagesRemoteDioDataSource extends Mock
    implements PackagesRemoteDioDataSource {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  setUpAll(
    () {
      TestWidgetsFlutterBinding.ensureInitialized();
    },
  );

  late MockPackagesRemoteDioDataSource mockDataSource;
  late MockSharedPreferences mockSharedPreferences;
  late PackagesRepository packagesRepository;

  setUp(
    () {
      mockDataSource = MockPackagesRemoteDioDataSource();
      mockSharedPreferences = MockSharedPreferences();

      when(() => mockSharedPreferences.getString(any()))
          .thenReturn('dummy_value');
      when(() => mockSharedPreferences.getInt(any())).thenReturn(1);

      packagesRepository = PackagesRepository(
        mockDataSource,
      );

      SharedPreferences.setMockInitialValues({});
    },
  );

  test(
    'should throw an exception when authentication details are missing',
    () async {
      when(() => mockSharedPreferences.getString('token')).thenReturn(null);

      expect(
        packagesRepository.fetchPackages(),
        throwsException,
      );
    },
  );
}
