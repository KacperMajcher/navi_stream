
import 'package:navi_stream/features/presentation/data/data_sources/channels_remote_data_source.dart';
import 'package:navi_stream/features/presentation/data/models/channel_model.dart';

class ChannelsRepository {
  ChannelsRepository({required this.remoteDataSource});
  final ChannelsRemoteDataSource remoteDataSource;

  Future<List<ChannelModel>> getChannelModels({
    required String token,
    required String ouid,
    required List<int> packageIds,
  }) async {
    final channels = await remoteDataSource.fetchChannels(
      token,
      ouid,
      packageIds,
    );
    return channels;
  }
}