import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The [StorageService] class that provides utility methods for initializing the SharedPreferences instance.
class StorageService extends GetxService {
  /// Initializes the SharedPreferences instance and returns it as a Future.
  ///
  /// This method uses the `SharedPreferences.getInstance()` method to get the SharedPreferences instance.
  /// The SharedPreferences instance is returned as a Future.
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }
}
