import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/features/presentation/data/models/channel_model.dart';
import 'package:navi_stream/features/presentation/data/models/package_model.dart';
import 'package:navi_stream/features/presentation/data/repositories/channel_repository.dart';
import 'package:navi_stream/features/presentation/data/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.homeRepository,
    this.channelsRepository,
  ) : super(HomeState());

  final HomeRepository homeRepository;
  final ChannelsRepository channelsRepository;

  // save necessary data for fetching packages
  void update(String ouid, String userId, String token) {
    emit(
      HomeState(
        ouid: ouid,
        userId: userId,
        token: token,
      ),
    );
    fetchPackages();
  }

  Future<void> fetchPackages() async {
    final String token = state.token!;
    final String ouid = state.ouid!;
    final String userId = state.userId!;

    // check if uid and ouid are definitely not null
    if (ouid.isEmpty || userId.isEmpty) {
      return;
    }

    try {
      final response = await homeRepository.fetchPackages(
        ouid,
        userId,
        token,
      );

      if (response.statusCode == 200) {
        // get data
        final List<dynamic> packageList = response.data['data'];

        // transfrom json list into models
        final List<Package> packages =
            packageList.map((data) => Package.fromJson(data)).toList();

        // filter packages, we dont need non purchased packages
        final List<Package> purchasedPackages =
            packages.where((package) => package.purchased != null).toList();

        // save purchased packages in state
        state.updatePackages(purchasedPackages);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getChannelModel() async {
    emit(
      HomeState(),
    );
    final channelModel = await channelsRepository.getChannelModel();
    emit(
      HomeState(
        channelModel: channelModel,
      ),
    );
  }
}
