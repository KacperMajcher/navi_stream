import 'package:flutter_test/flutter_test.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/features/home/data/models/channel_dto.dart';

void main() {
  final testDTO = ChannelDTO(
    id: 1,
    name: 'HBO GO',
    logos: {
      'NORMAL': 123,
    },
  );

  final testDTOJson = {
    'id': 1,
    'name': 'HBO GO',
    'logos': {
      'NORMAL': 123,
    }
  };

  group(
    'ChannelDTO tests',
    () {
      group(
        'instantiation test',
        () {
          test(
            'should correctly instantiate',
            () {
              expect(testDTO.id, 1);
              expect(testDTO.name, 'HBO GO');
              expect(
                testDTO.logos,
                {'NORMAL': 123},
              );
            },
          );
        },
      );

      group(
        'serialization tests',
        () {
          test(
            'should serialize to JSON',
            () {
              final result = testDTO.toJson();

              expect(result, testDTOJson);
            },
          );
          test(
            'should deserialize from JSON',
            () {
              final result = ChannelDTO.fromJson(testDTOJson);

              expect(result.id, 1);
              expect(result.name, 'HBO GO');
              expect(
                result.logos,
                {'NORMAL': 123},
              );
            },
          );

          test(
            'ChannelDTO conversion to model',
            () {
              final result = testDTO.convertToModel();

              expect(result.channelName, 'HBO GO');
              expect(result.logoId, 123);
              expect(result.channelLogo,
                  '${apiBaseURL}v1/global/images/${result.logoId}?$logoAccessKey');
            },
          );
        },
      );
      group(
        'logos tests',
        () {
          test(
            'should handle CARD logo',
            () {
              final dto = ChannelDTO(
                id: 1,
                name: 'HBO GO',
                logos: {
                  'CARD': 111,
                },
              );

              final result = dto.convertToModel();

              expect(result.logoId, 111);
            },
          );

          test(
            'should handle SHADOW logo',
            () {
              final dto = ChannelDTO(
                id: 1,
                name: 'HBO GO',
                logos: {
                  'SHADOW': 222,
                },
              );

              final result = dto.convertToModel();

              expect(result.logoId, 222);
            },
          );

          test(
            'should handle LEGACY logo',
            () {
              final dto = ChannelDTO(
                id: 1,
                name: 'HBO GO',
                logos: {
                  'LEGACY': 333,
                },
              );

              final result = dto.convertToModel();

              expect(result.logoId, 333);
            },
          );
        },
      );
    },
  );
}
