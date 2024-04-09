import 'package:dio/dio.dart';
import 'package:navi_stream/features/presentation/data/data_sources/channels_remote_data_source.dart';
import 'package:navi_stream/features/presentation/data/models/channel_dto.dart';
import 'package:navi_stream/features/presentation/data/models/channel_model.dart';

class ChannelsRepository {
  ChannelsRepository({required this.remoteDataSource});
  final ChannelsRemoteDataSource remoteDataSource;

  Future<List<ChannelModel>> getChannelModels({
    required String token,
    required String ouid,
    required List<int> packageIds,
  }) async {
    try {
      final channels = await remoteDataSource.fetchChannels(
        token,
        ouid,
        packageIds,
      ); // channels is http response now

      if (channels.response.statusCode == 200) {
        final List<ChannelDTO> channelDTOs = channels.data.data;

        // transform list of dto's into models
        final List<ChannelModel> channelModels =
            channelDTOs.map<ChannelModel>((dto) => dto.toDomain()).toList();

        return channelModels;
      } else if (channels.response.statusCode == 401) {
        throw Exception('Unauthorized access.');
      } else {
        throw Exception(
          'Error fetching data. Status code: ${channels.response.statusCode}',
        );
      }
    } on DioException catch (error) {
      final errorMessage = error.response != null
          ? 'Error: ${error.response?.statusCode} ${error.response?.data}'
          : 'Unknown Dio error';
      throw Exception(errorMessage);
    }
  }
}
