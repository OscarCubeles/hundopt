class Shelter {
  String id;
  String name;
  String email;
  String phone;
  String location;
  String pictureURL;
  List<String>? dogsId;
  String facebook;
  String linkedin;
  String twitter;
  String tiktok;

  Shelter(
      {required this.name,
      required this.id,
      required this.pictureURL,
      required this.dogsId,
      required this.facebook,
      required this.twitter,
      required this.tiktok,
      required this.linkedin,
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
        facebook = '',
        linkedin = '',
        tiktok = '',
        twitter = '';
}
