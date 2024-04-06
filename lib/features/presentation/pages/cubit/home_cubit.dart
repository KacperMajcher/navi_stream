import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
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
  }
}
