import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navi_stream/features/authButRiverpod/notifiers/auth_notifier.dart';
import 'package:navi_stream/features/authButRiverpod/services/api_services.dart';
import 'package:navi_stream/features/authButRiverpod/services/auth_services.dart';
import 'package:navi_stream/features/authButRiverpod/services/storage_service.dart';

final storageServiceProvider = Provider((ref) => StorageService());
final apiServicesProvider = Provider((ref) => ApiServices());

final authServicesProvider = Provider(
  (ref) {
    final apiServices = ref.watch(
      apiServicesProvider,
    );
    final storageService = ref.watch(
      storageServiceProvider,
    );
    return AuthServices(
      apiServices,
      storageService,
    );
  },
);

final authNotifierProvider = StateNotifierProvider(
  (ref) {
    final authServices = ref.watch(
      authServicesProvider,
    );
    return AuthNotifier(
      authServices,
    );
  },
);
