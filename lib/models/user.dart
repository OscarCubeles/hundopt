class HundoptUser {
  String id;
  String username;
  String email;
  String fullName;
  String phone;
  String pictureURL;
  String personalityFormID;
  List<String> adoptingDogs;

  HundoptUser({
    required this.fullName,
    required this.personalityFormID,
    required this.id,
    required this.username,
    required this.email,
    required this.pictureURL,
    required this.phone,
    required this.adoptingDogs,
  });

  HundoptUser.withEmailAndUsername({
    required this.email,
    required this.username,
  })  : id = '',
        fullName = '',
        phone = '',
        pictureURL = '',
        personalityFormID = '',
        adoptingDogs = [];

  factory HundoptUser.fromJson(Map<String, dynamic> json) => HundoptUser(
        personalityFormID: json['personalityFormID'] as String,
        id: json['id'] as String,
        username: json['username'] as String,
        fullName: json['fullname'] ,
        email: json['email'] as String,
        pictureURL: json['pictureURL'] as String,
        phone: json['phone'] as String,
        adoptingDogs: List<String>.from(json['adoptingDogs'] as List<dynamic>),
      );
}
