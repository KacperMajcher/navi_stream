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

  final testModel1 = ChannelModel(
    channelName: 'test1',
    logoId: 1,
    channelLogo: 'logo1',
  );

  final testModel2 = ChannelModel(
    channelName: 'test2',
    logoId: 2,
    channelLogo: 'logo2',
  );

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
    'HomeCubit tests',
    () {
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
                  testModel1,
                ],
              );
            },
            build: () => sut,
            act: (cubit) => cubit.init(),
            expect: () => [
              HomeState(
                status: Status.success,
                channelModel: [
                  testModel1,
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
      group(
        'filterChannels()',
        () {
          group(
            'empty value',
            () {
              blocTest<HomeCubit, HomeState>(
                'should first return everything and then only those models in which the title matches the given value on success',
                build: () {
                  when(() => mockPackagesRepository.fetchPackages()).thenAnswer(
                    (_) async => [
                      const PackageModel(
                        id: 1,
                      ),
                    ],
                  );
                  when(
                    () => mockChannelsRepository.getChannelModels(
                      packageIds: any(
                        named: 'packageIds',
                      ),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      testModel1,
                      testModel2,
                    ],
                  );
                  return sut;
                },
                act: (cubit) async {
                  await cubit.init();
                  cubit.filterChannels('');
                },
                expect: () => [
                  HomeState(
                    status: Status.success,
                    channelModel: [
                      testModel1,
                      testModel2,
                    ],
                  ),
                ],
              );
            },
          );
          group(
            'provided value',
            () {
              blocTest<HomeCubit, HomeState>(
                'should first return everything and then only those models in which the title matches the given value on success',
                build: () {
                  when(
                    () => mockPackagesRepository.fetchPackages(),
                  ).thenAnswer(
                    (_) async => [
                      const PackageModel(
                        id: 1,
                      ),
                    ],
                  );
                  when(
                    () => mockChannelsRepository.getChannelModels(
                      packageIds: any(
                        named: 'packageIds',
                      ),
                    ),
                  ).thenAnswer(
                    (_) async => [
                      testModel1,
                      testModel2,
                    ],
                  );
                  return sut;
                },
                act: (cubit) async {
                  await cubit.init();
                  cubit.filterChannels('test1');
                },
                expect: () => [
                  HomeState(
                    status: Status.success,
                    channelModel: [
                      testModel1,
                      testModel2,
                    ],
                  ),
                  HomeState(
                    status: Status.success,
                    channelModel: [
                      testModel1,
                    ],
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}
