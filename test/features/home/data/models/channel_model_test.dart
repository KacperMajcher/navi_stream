import 'package:flutter_test/flutter_test.dart';
import 'package:navi_stream/features/home/data/models/channel_model.dart';

void main() {
  group(
    'ChannelModel tests',
    () {
      final channelModel = ChannelModel(
        channelName: 'Canal+ Sport',
        logoId: 3,
        channelLogo: 'logo.png',
      );

      final json = {
        'channelName': 'Canal+ Sport',
        'logoId': 3,
        'channelLogo': 'logo.png',
      };

      group(
        'instantiation test',
        () {
          test(
            'should correctly instantiate',
            () {
              expect(channelModel.channelName, 'Canal+ Sport');
              expect(channelModel.logoId, 3);
              expect(channelModel.channelLogo, 'logo.png');
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
              final result = channelModel.toJson();

              expect(result, json);
            },
          );

          test(
            'should deserialize from JSON',
            () {
              final result = ChannelModel.fromJson(json);

              expect(result, channelModel);
            },
          );
        },
      );
    },
  );
}
