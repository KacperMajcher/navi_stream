import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_stream/core/constants/enums.dart';
import 'package:navi_stream/features/presentation/data/repositories/packages_repository.dart';
import 'package:navi_stream/features/presentation/pages/cubit/packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  final PackagesRepository packagesRepository;

  PackagesCubit(this.packagesRepository)
      : super(
          const PackagesState(status: Status.loading),
        );

  Future<void> fetchPackages(
    String ouid,
    String userId,
    String token,
  ) async {
    final packages = await packagesRepository.fetchPackages(
      ouid,
      userId,
      token,
    );
    emit(
      PackagesState(
        status: Status.success,
        packages: packages,
      ),
    );
  }
}
