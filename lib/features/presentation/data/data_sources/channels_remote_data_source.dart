import 'package:dio/dio.dart';
import 'package:navi_stream/core/constants/constants.dart';
import 'package:navi_stream/features/presentation/data/models/channel_model.dart';

class ChannelsRemoteDataSource {
  Future<List<ChannelModel>> fetchChannels(
      String token, String ouid, List<int> packageIds) async {
    try {
      final response = await Dio().get(
        '${apiBaseURL}v2/$ouid/channels',
        queryParameters: {'packages': packageIds},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> channelsData = response.data['data'];

        final data = channelsData
            .map<ChannelModel>(
                (channelData) => ChannelModel.fromJson(channelData))
            .toList();

        return data;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized access.');
      } else {
        throw Exception(
          'Error fetching data. Status code: ${response.statusCode}',
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
