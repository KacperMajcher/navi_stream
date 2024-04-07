import 'package:navi_stream/features/presentation/data/models/channel_model.dart';

class ChannelsRepository {
  Future<ChannelModel> getChannelModel() async {
    return ChannelModel(
        channelName: 'Canal+ Cinema', channelLogo: 'assets/logo_test.jpg');
  }
}
