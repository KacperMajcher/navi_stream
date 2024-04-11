import 'package:dio/dio.dart';
import 'package:navi_stream/features/home/data/data_sources/channels_remote_data_source.dart';
import 'package:navi_stream/features/home/data/models/channel_dto.dart';
import 'package:navi_stream/features/home/data/models/channel_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChannelsRepository {
  ChannelsRepository(this.remoteDataSource);
  final ChannelsRemoteDataSource remoteDataSource;

  Future<List<ChannelModel>> getChannelModels({
    required List<int> packageIds,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token')!;
      final String ouid = prefs.getString('ouid')!;

      final channels = await remoteDataSource.fetchChannels(
        token,
        ouid,
        packageIds,
      ); 

      if (channels.response.statusCode == 200) {
        final List<ChannelDTO> channelDTOs = channels.data.data;

        final List<ChannelModel> channelModels = channelDTOs
            .map<ChannelModel>((dto) => dto.convertToModel())
            .toList();

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
