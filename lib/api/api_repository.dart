import 'dart:async';


import '../models/request/login_request.dart';
import '../models/request/register_request.dart';
import '../models/response/login_response.dart';
import '../models/response/register_response.dart';
import '../models/response/users_response.dart';
import 'api.dart';
import 'api_provider.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<LoginResponse?> login(LoginRequest data) async {
    String email = data.email;
    String password = data.password;
    final res = await apiProvider.login('/login?email=$email&pw=$password', data);
    print(res.body);
    // TODO: CHeck the response body, always gives a 200 status code
    if (res.statusCode == 600) {
      return LoginResponse.fromJson(res.body);
    }
    return null;
  }

  Future<RegisterResponse?> register(RegisterRequest data) async {
    final res = await apiProvider.register('/users', data);
    if (res.statusCode == 200) {
      return RegisterResponse.fromJson(res.body);
    }
  }



  Future<UsersResponse?> getUsers() async {
    final res = await apiProvider.getUsers('/api/users?page=1&per_page=12');
    if (res.statusCode == 200) {
      return UsersResponse.fromJson(res.body);
    }
  }
}
