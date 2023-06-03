import 'package:get/get.dart';

import 'api.dart';
import 'api_constants.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/request_interceptor.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    // TODO: Remove this if not used
    httpClient.baseUrl = ApiConstants.baseUrl;
    httpClient.addAuthenticator(authInterceptor);
    httpClient.addRequestModifier(requestInterceptor);
  }
}
