class HundoptUser {
  String id;
  String username;
  String email;
  String fullName;
  String phone;
  String pictureURL;
  String personalityFormID;
  List<String>? adoptingDogs;
  List<String>? favDogs;
  List<String>? favShelters;

  HundoptUser(
      {required this.fullName,
      required this.personalityFormID,
      required this.id,
      required this.username,
      required this.email,
      required this.pictureURL,
      required this.phone,
      required this.adoptingDogs,
      required this.favDogs,
      required this.favShelters});

  HundoptUser.withEmailAndUsername({
    required this.email,
    required this.username,
  })  : id = '',
        fullName = '',
        phone = '',
        pictureURL = '',
        personalityFormID = '',
        adoptingDogs = [],
        favShelters = [],
        favDogs = [];

  HundoptUser.empty()
      : id = '',
        email = '',
        username = '',
        fullName = '',
        phone = '',
        pictureURL = '',
        personalityFormID = '',
        adoptingDogs = [],
        favShelters = [],
        favDogs = [];

  factory HundoptUser.fromJson(Map<String, dynamic> json) => HundoptUser(
        personalityFormID: json['personalityFormID'] as String,
        id: json['id'] as String,
        username: json['username'] as String,
        fullName: json['fullname'],
        email: json['email'] as String,
        pictureURL: json['pictureURL'] as String,
        phone: json['phone'] as String,
        adoptingDogs: List<String>.from(json['adoptingDogs'] as List<dynamic>),
        favDogs: List<String>.from(json['favDogs'] as List<dynamic>),
        favShelters: List<String>.from(json['favShelters'] as List<dynamic>),
      );
}
