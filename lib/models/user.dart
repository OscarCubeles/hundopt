class User {
  String id;
  String name;
  String email;
  String phone;
  String picture;
  String location;
  String personalityFormID;
  List<String> adoptingDogs;



  User(
      { required this.personalityFormID,
        required this.id,
        required this.name,
        required this.email,
        required this.picture,
        required this.phone,
        required this.location,
        required this.adoptingDogs,
      });
}
