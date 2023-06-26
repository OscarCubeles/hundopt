/// The [HundoptUser] class models a Hundopt user object.
/// Hundopt users will be default client users that can use the app
class HundoptUser {
  /// The ID of the user.
  String id;

  /// The username of the user.
  String username;

  /// The email of the user.
  String email;

  /// The full name of the user.
  String fullName;

  /// The phone number of the user.
  String phone;

  /// The URL of the picture of the user.
  String pictureURL;

  /// The ID of the personality form of the user.
  String personalityFormID;

  /// The IDs of the dogs the user is adopting.
  List<String> adoptingDogs;

  /// The IDs of the user's favorite dogs.
  List<String> favDogs;

  /// The IDs of the user's favorite shelters.
  List<String> favShelters;

  /// Constructs a new instance of the [HundoptUser] class with the specified parameters.
  ///
  /// The [fullName], [personalityFormID], [id], [username], [email], [pictureURL],
  /// [phone], [adoptingDogs], [favDogs], and [favShelters] parameters must not be null.
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

  /// Constructs a new instance of [HundoptUser] with the given parameters.
  ///
  /// The [email] and [username] parameters are required,
  /// while the remaining properties are set to default values.
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

  /// Creates an empty [HundoptUser] object.
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

  /// Creates a [HundoptUser] object from a JSON-compatible Map.
  ///
  /// The [HundoptUser.fromJson()] factory constructor takes a [Map] representing a
  /// JSON object and creates a [HundoptUser] object from its fields. The keys in
  /// the map should correspond to the field names of the [HundoptUser] class.
  /// If a key is missing or its corresponding value is null, a default value
  /// is used for that field. The included fields are 'personalityFormID', 'id',
  /// 'username', 'fullname', 'email', 'pictureURL', 'phone', 'adoptingDogs',
  /// 'favDogs', and 'favShelters'.
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
