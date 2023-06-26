import '../../../../models/shelter.dart';

/// The [ShelterSingleton] class stores the list of shelters and the index of the current shelter.
class ShelterSingleton {
  /// The instance of the `ShelterSingleton` class.
  static final ShelterSingleton _instance = ShelterSingleton._internal();

  /// Returns the instance of the `ShelterSingleton` class.
  factory ShelterSingleton() => _instance;

  /// The list of shelters.
  List<Shelter> shelters = [];

  /// The index of the current shelter.
  int shelterIndex = 0;

  /// Private constructor for the `ShelterSingleton` class.
  ShelterSingleton._internal();
}
