import 'package:flutter_test/flutter_test.dart';
import 'package:navi_stream/features/home/data/models/channel_dto.dart';
import 'package:navi_stream/features/home/data/models/channel_response.dart';

void main() {
  final testDTO = ChannelDTO(
    id: 1,
    name: 'HBO GO',
    logos: {
      'NORMAL': 123,
    },
  );

  final testResponse = ChannelResponse(
    data: [
      testDTO,
    ],
  );

  final testResponseJson = {
    'data': [
      {
        'id': 1,
        'name': 'HBO GO',
        'logos': {
          'NORMAL': 123,
        },
      },
    ],
  };

  group('ChannelResponse serialization tests', () {
    test(
      'should serialize to JSON',
      () {
        final result = testResponse.toJson();

        expect(result, equals({'data': isA()}));
      },
    );
  });

  test(
    'should deserialize from JSON',
    () async {
      final result = ChannelResponse.fromJson(testResponseJson);

      expect(
        result.data[0].id,
        equals(testResponse.data[0].id),
      );
      expect(
        result.data[0].name,
        equals(testResponse.data[0].name),
      );
      expect(
        result.data[0].logos,
        equals(testResponse.data[0].logos),
      );
    },
  );
}
