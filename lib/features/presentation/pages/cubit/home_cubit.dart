import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:navi_stream/features/presentation/data/repositories/home_repository.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit(this.homeRepository)
      : super(
          HomeState(
            ouid: '',
            userId: '',
            token: '',
          ),
        );
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
    final String token = state.token;
    final String ouid = state.ouid;
    final String userId = state.userId;

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
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }
}
