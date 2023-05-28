import 'dart:convert';

class RegisterRequest {
  RegisterRequest(
      {required this.email,
      required this.password,
      required this.phone,
      required this.name});

  String email;
  String password;
  String phone;
  String name;

  factory RegisterRequest.fromRawJson(String str) =>
      RegisterRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
          email: json["email"],
          password: json["pw"],
          phone: json["telefono"],
          name: json["nombre"]);

  Map<String, dynamic> toJson() =>
      {"email": email, "pw": password, "telefono": phone, "nombre": name};
}
