import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/home/data/models/channel_model.dart';
import 'package:navi_stream/features/home/pages/cubit/home_state.dart';

class MockChannelModel extends Mock implements ChannelModel {}

void main() {
  final jsonMap = {
    'status': 'loading',
    'channelModel': [
      {
        'channelName': 'Channel 1',
        'logoId': 1,
        'channelLogo': 'logo 1',
      },
      {
        'channelName': 'Channel 2',
        'logoId': 2,
        'channelLogo': 'logo 2',
      },
    ],
  };

  final expectedChannelModels = [
    ChannelModel(
      channelName: 'Channel 1',
      logoId: 1,
      channelLogo: 'logo 1',
    ),
    ChannelModel(
      channelName: 'Channel 2',
      logoId: 2,
      channelLogo: 'logo 2',
    ),
  ];

  group(
    'HomeState tests',
    () {
      test(
        'fromJson should correctly deserialize JSON',
        () {
          final state = HomeState.fromJson(jsonMap);

          expect(
            state.status,
            equals(Status.loading),
          );

          expect(
            state.channelModel,
            equals(expectedChannelModels),
          );
        },
      );

      test(
        'toJson should correctly serialize to JSON',
        () {
          final state = HomeState(
            status: Status.loading,
            channelModel: expectedChannelModels,
          );

          final jsonMap = state.toJson();

          final List<Map<String, dynamic>> expectedChannelModelMaps = state
              .channelModel
              .map((channelModel) => channelModel.toJson())
              .toList();

          expect(jsonMap, jsonMap);
          expect(
            json.encode(jsonMap['channelModel']),
            equals(
              json.encode(
                expectedChannelModelMaps,
              ),
            ),
          );
        },
      );
    },
  );
}
