class Shelter {
  String id;
  String name;
  String email;
  String phone;
  String location;
  String pictureURL;
  List<String>? dogsId;
  List<String>? socialNetworks;

  Shelter(
      {required this.name,
      required this.id,
      required this.pictureURL,
      required this.dogsId,
      required this.socialNetworks,
      required this.email,
      required this.phone,
      required this.location});

  Shelter.empty()
      : id = '',
        email = '',
        location = '',
        phone = '',
        pictureURL = '',
        name = '',
        dogsId = [],
        socialNetworks = [];
}
