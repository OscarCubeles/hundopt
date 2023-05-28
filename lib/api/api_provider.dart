
import 'package:get/get.dart';

import '../models/request/login_request.dart';
import '../models/request/register_request.dart';
import 'base_provider.dart';

class ApiProvider extends BaseProvider {
  Future<Response> login(String path, LoginRequest data) { // TODO: Unused data as it is a get not a post request
    return get(path);
  }

  Future<Response> register(String path, RegisterRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> getUsers(String path) {
    return get(path);
  }
}
