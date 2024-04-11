import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navi_stream/features/home/data/repositories/channel_repository.dart';
import 'package:navi_stream/features/home/data/repositories/packages_repository.dart';
import 'package:navi_stream/features/home/pages/cubit/home_cubit.dart';
import 'package:navi_stream/features/home/pages/cubit/home_state.dart';
import 'package:navi_stream/core/constants/enums.dart';

class MockPackagesRepository extends Mock implements PackagesRepository {}

class MockChannelsRepository extends Mock implements ChannelsRepository {}

void main() {
  late MockPackagesRepository mockPackagesRepository;
  late MockChannelsRepository mockChannelsRepository;
  late HomeCubit sut;

  setUp(
    () {
      mockPackagesRepository = MockPackagesRepository();
      mockChannelsRepository = MockChannelsRepository();
      sut = HomeCubit(
          packagesRepository: mockPackagesRepository,
          channelsRepository: mockChannelsRepository);
    },
  );

  group(
    'HoginState tests',
    () {
      test(
        'initial state is HomeState.loading',
        () {
          expect(
            sut.state,
            const HomeState(
              status: Status.loading,
            ),
          );
        },
      );
    },
  );
}
