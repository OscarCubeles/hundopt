/// The [Shelter] class models a Shelter object.
class Shelter {
  /// The ID of the shelter.
  String id;

  /// The name of the shelter.
  String name;

  /// The email of the shelter.
  String email;

  /// The phone number of the shelter.
  String phone;

  /// The location of the shelter.
  String location;

  /// The URL of the picture of the shelter.
  String pictureURL;

  /// The IDs of the dogs in the shelter.
  List<String>? dogsId;

  /// The Facebook page of the shelter.
  String facebook;

  /// The LinkedIn page of the shelter.
  String linkedin;

  /// The Twitter page of the shelter.
  String twitter;

  /// The TikTok page of the shelter.
  String tiktok;

  /// Constructs a new instance of the [Shelter] class with the specified parameters.
  ///
  /// The [name], [id], [pictureURL], [dogsId], [facebook], [twitter], [tiktok],
  /// [linkedin], [email], and [phone] parameters must not be null.
  Shelter({
    required this.name,
    required this.id,
    required this.pictureURL,
    required this.dogsId,
    required this.facebook,
    required this.twitter,
    required this.tiktok,
    required this.linkedin,
    required this.email,
    required this.phone,
    required this.location,
  });

  /// Creates an empty [Shelter] object.
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

  /// Checks if the [HundoptUser] has any social networks.
  ///
  /// The [hasSocialNetworks] method determines whether the [HundoptUser] has any
  /// associated social networks such as LinkedIn, TikTok, Facebook, or Twitter.
  /// It returns `true` if at least one social network is present, and `false`
  /// if none of the social networks are available.
  bool hasSocialNetworks() {
    return !(linkedin == "" && tiktok == "" && facebook == "" && twitter == "");
  }

  /// Creates a [Shelter] object from a JSON-compatible Map.
  ///
  /// The [Shelter.fromMap()] factory constructor takes a [Map] representing a
  /// JSON object and creates a [Shelter] object from its fields. The keys in
  /// the map should correspond to the field names of the [Shelter] class.
  /// If a key is missing or its corresponding value is null, a default value
  /// is used for that field. The included fields are 'name', 'pictureURL',
  /// 'location', 'id', 'email', 'facebook', 'linkedin', 'twitter', 'tiktok',
  /// 'phone', and 'dogsId'.
  factory Shelter.fromMap(Map<String, dynamic> map) {
    return Shelter(
      name: map['name'] ?? '',
      pictureURL: map['pictureURL'] ?? '',
      location: map['location'] ?? '',
      id: map['id'] ?? '',
      email: map['email'] ?? 0,
      facebook: map['facebook'] ?? '',
      linkedin: map['linkedin'] ?? '',
      twitter: map['twitter'] ?? '',
      tiktok: map['tiktok'] ?? '',
      phone: map['phone'] ?? '',
      dogsId: List<String>.from(map['dogs-id'] ?? []),
    );
  }
}
