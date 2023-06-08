class Dog {
  String name;
  String mainPictureURL;
  String location;
  String id;
  int age;
  String breed;
  String description;
  String gender;
  bool isReserved;
  String shelterID;
  String size;
  List<String> personality;
  List<String> friendly;
  List<String> notFriendly;
  List<String> pictureURLs;
  List<String> healthNegative;
  List<String> healthPositive;

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

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
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
