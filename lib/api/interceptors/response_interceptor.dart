import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hundopt/models/model.dart';
import 'package:hundopt/shared/shared.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../../models/response/error_response.dart';

FutureOr<dynamic> responseInterceptor(
    Request request, Response response) async {
  EasyLoading.dismiss();

  if (response.statusCode != 200) {
    handleErrorStatus(response);
    return;
  }

  return response;
}

void handleErrorStatus(Response response) {
  switch (response.statusCode) {
    case 400:
      final message = ErrorResponse.fromJson(response.body);
      print(message.error);
      break;
    default:
  }

  return;
}
