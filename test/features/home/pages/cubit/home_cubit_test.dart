import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navi_stream/features/home/data/repositories/channel_repository.dart';
import 'package:navi_stream/features/home/data/repositories/packages_repository.dart';
import 'package:navi_stream/features/home/pages/cubit/home_cubit.dart';
import 'package:navi_stream/features/home/pages/cubit/home_state.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/home/data/models/channel_model.dart';
import 'package:navi_stream/features/home/data/models/package_model.dart';

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
        channelsRepository: mockChannelsRepository,
      );
    },
  );

  group(
    'success',
    () {
      blocTest<HomeCubit, HomeState>(
        'should emits an success when fetching packages is successful',
        setUp: () {
          when(mockPackagesRepository.fetchPackages).thenAnswer(
            (_) async => [
              const PackageModel(
                id: 1,
              ),
            ],
          );
          when(() => mockChannelsRepository.getChannelModels(
              packageIds: any(named: 'packageIds'))).thenAnswer(
            (_) async => [
              ChannelModel(
                channelName: 'HBO',
                logoId: 1,
                channelLogo: 'logo.png',
              )
            ],
          );
        },
        build: () => sut,
        act: (cubit) => cubit.init(),
        expect: () => [
          HomeState(
            status: Status.success,
            channelModel: [
              ChannelModel(
                channelName: 'HBO',
                logoId: 1,
                channelLogo: 'logo.png',
              ),
            ],
          ),
        ],
      );
    },
  );

  group(
    'failure',
    () {
      blocTest<HomeCubit, HomeState>(
        'should emits an error when fetching packages fails',
        setUp: () {
          when(mockPackagesRepository.fetchPackages).thenThrow(
            Exception(
              'Failed to fetch packages',
            ),
          );
        },
        build: () => sut,
        act: (cubit) => cubit.init(),
        expect: () => [
          const HomeState(
            status: Status.error,
          ),
        ],
      );
    },
  );
}
