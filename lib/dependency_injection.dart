import 'package:get/get.dart';
import 'shared/services/services.dart';

/// The [DependencyInjection] class is responsible for initializing the dependencies of the application.
class DependencyInjection {
  /// Initializes the dependencies of the application.
  ///
  /// This method initializes the `StorageService` dependency using `Get.putAsync()`.
  /// It is an asynchronous method that returns a `Future<void>`.
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
  }
}
