import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect/http/src/request/request.dart';
// TODO: Remove this if not used

FutureOr<Request> requestInterceptor(request) async {
  // final token = StorageService.box.pull(StorageItems.accessToken);

  // request.headers['X-Requested-With'] = 'XMLHttpRequest';
  // request.headers['Authorization'] = 'Bearer $token';

  EasyLoading.show(status: 'loading...');
  return request;
}
