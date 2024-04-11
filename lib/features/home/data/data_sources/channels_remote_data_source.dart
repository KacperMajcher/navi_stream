import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:navi_stream/features/home/data/models/channel_response.dart';
import 'package:retrofit/retrofit.dart';

part 'channels_remote_data_source.g.dart';

@injectable
@RestApi()
abstract class ChannelsRemoteDataSource {
  @factoryMethod
  factory ChannelsRemoteDataSource(Dio dio) = _ChannelsRemoteDataSource;

  @GET("/v2/{ouid}/channels")
  Future<HttpResponse<ChannelResponse>> fetchChannels(
    @Header("Authorization") String token,
    @Path("ouid") String ouid,
    @Query("packages") List<int> packageIds,
  );
}
