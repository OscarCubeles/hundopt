/// The [Dog] class models a Dog object.
class Dog {
  /// The name of the dog.
  String name;

  /// The URL of the main picture of the dog.
  String mainPictureURL;

  /// The location of the dog.
  String location;

  /// The ID of the dog.
  String id;

  /// The age of the dog.
  int age;

  /// The breed of the dog.
  String breed;

  /// The description of the dog.
  String description;

  /// The gender of the dog.
  String gender;

  /// Whether the dog is reserved or not.
  bool isReserved;

  /// The ID of the shelter where the dog is located.
  String shelterID;

  /// The size of the dog.
  String size;

  /// The list of personality traits of the dog.
  List<String> personality;

  /// The list of friendly traits of the dog.
  List<String> friendly;

  /// The list of not-friendly traits of the dog.
  List<String> notFriendly;

  /// The list of URLs of pictures of the dog.
  List<String> pictureURLs;

  /// The list of negative health conditions of the dog.
  List<String> healthNegative;

  /// The list of positive health conditions of the dog.
  List<String> healthPositive;

  /// Constructs a new instance of the [Dog] class with the specified parameters.
  ///
  /// The [name], [mainPictureURL], [location], [id], [age], [breed],
  /// [description], [gender], [isReserved], [shelterID], [size], [personality],
  /// [friendly], [notFriendly], [pictureURLs], [healthNegative],
  /// and [healthPositive] parameters must not be null.
  Dog({
    required this.personality,
    required this.name,
    required this.id,
    required this.age,
    required this.location,
    required this.breed,
    required this.description,
    required this.friendly,
    required this.notFriendly,
    required this.gender,
    required this.healthPositive,
    required this.healthNegative,
    required this.isReserved,
    required this.mainPictureURL,
    required this.pictureURLs,
    required this.shelterID,
    required this.size,
  });

  /// Constructs a new instance of [Dog] with the given parameters.
  ///
  /// The [name], [mainPictureURL], and [location] parameters are required,
  /// while the remaining properties are set to default values.
  Dog.simplified(
      {required this.name,
      required this.mainPictureURL,
      required this.location})
      : id = '',
        breed = '',
        isReserved = false,
        age = 0,
        description = '',
        gender = '',
        shelterID = '',
        size = '',
        friendly = [],
        notFriendly = [],
        pictureURLs = [],
        healthNegative = [],
        personality = [],
        healthPositive = [];

  /// Converts the [Dog] object to a JSON-compatible Map.
  ///
  /// Returns a Map representing the [Dog] object in a format that can be
  /// easily serialized to JSON. The keys in the map are the field names of the
  /// [Dog] class, and the values are the corresponding values of the fields.
  /// The included fields are 'id', 'name', 'age', 'location', 'gender', 'breed',
  /// 'description', 'isReserved', 'shelterID', 'size', 'friendly', 'personality',
  /// 'notFriendly', 'healthPositive', 'healthNegative', 'mainPictureURL', and 'pictureURLs'.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'location': location,
      'gender': gender,
      'breed': breed,
      'description': description,
      'isReserved': isReserved,
      'shelterID': shelterID,
      'size': size,
      'friendly': friendly,
      'personality': personality,
      'notFriendly': notFriendly,
      'healthPositive': healthPositive,
      'healthNegative': healthNegative,
      'mainPictureURL': mainPictureURL,
      'pictureURLs': pictureURLs,
    };
  }

  /// Constructs a new instance of the [Dog] class from a [Map] of key-value pairs.
  ///
  /// The [map] parameter must not be null.
  ///
  /// The returned [Dog] instance will have its fields populated with the values from the [map] parameter.
  /// If a key is not present in the [map], the corresponding field will be initialized to a default value.
  factory Dog.fromMap(Map<String, dynamic> map) {
    return Dog(
      name: map['name'] ?? '',
      mainPictureURL: map['mainPictureURL'] ?? '',
      location: map['location'] ?? '',
      id: map['id'] ?? '',
      age: map['age'] ?? 0,
      breed: map['breed'] ?? '',
      description: map['description'] ?? '',
      gender: map['gender'] ?? '',
      isReserved: map['isReserved'] ?? false,
      shelterID: map['shelterID'] ?? '',
      size: map['size'] ?? '',
      personality: List<String>.from(map['personality'] ?? []),
      friendly: List<String>.from(map['friendly'] ?? []),
      notFriendly: List<String>.from(map['notFriendly'] ?? []),
      pictureURLs: List<String>.from(map['pictureURLs'] ?? []),
      healthNegative: List<String>.from(map['healthNegative'] ?? []),
      healthPositive: List<String>.from(map['healthPositive'] ?? []),
    );
  }
}
