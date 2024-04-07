import 'package:navi_stream/features/presentation/data/models/channel_model.dart';

class ChannelsMockedDataSource {
  Future<List<ChannelModel>> getChannels() async {
    return [
      ChannelModel(
          channelName: 'Canal+ Cinema', channelLogo: 'assets/logo_test.jpg'),
      ChannelModel(channelName: 'HBO GO', channelLogo: 'assets/logo_test.jpg'),
      ChannelModel(
          channelName: 'Canal+ Sport', channelLogo: 'assets/logo_test.jpg'),
    ];
  }
}
