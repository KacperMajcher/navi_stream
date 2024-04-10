import 'package:flutter_test/flutter_test.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/features/presentation/data/models/channel_dto.dart';
import 'package:navi_stream/features/presentation/data/models/channel_response.dart';

void main() {
  final testDTO = ChannelDTO(
    id: 1,
    name: 'HBO GO',
    logos: {
      'NORMAL': 123,
    },
  );

  final testDTOJson = {
    "id": 1,
    "name": "HBO GO",
    "logos": {
      "NORMAL": 123,
    }
  };

  group('ChannelResponse tests', () {
    group('instantiation test', () {
      test('should correctly instantiate', () {
        final result = ChannelResponse(data: [testDTO]);

        expect(result.data.first, testDTO);
        expect(result.data.length, 1);
      });
    });

    group('serialization tests', () {
      test('should serialize to JSON', () {
        final jsonMap = testDTO.toJson();

        expect(jsonMap, testDTOJson);
      });

      test('should deserialize from JSON', () {
        final result = ChannelDTO.fromJson(testDTOJson);

        expect(result.id, testDTO.id);
        expect(result.name, testDTO.name);
        expect(result.logos, testDTO.logos);
      });

      test('convertToModel should return ChannelModel', () {
        final result = testDTO.convertToModel();

        expect(result.channelName, 'HBO GO');
        expect(result.logoId, 123);
        expect(result.channelLogo,
            '${apiBaseURL}v1/global/images/123?$logoAccessKey');
      });
    });
  });
}
