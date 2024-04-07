import 'package:navi_stream/features/presentation/data/data_sources/channels_mocked_data_source.dart';
import 'package:navi_stream/features/presentation/data/models/channel_model.dart';

class ChannelsRepository {
  ChannelsRepository({required this.remoteDataSource});
  final ChannelsMockedDataSource remoteDataSource;

  Future<List<ChannelModel>> getChannelModels() async {
    final channels = await remoteDataSource.getChannels();
    return channels;
  }
}
