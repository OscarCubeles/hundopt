import 'package:hundopt/models/shelter.dart';

class ShelterSingleton {
  static final ShelterSingleton _instance = ShelterSingleton._internal();
  factory ShelterSingleton() => _instance;

  List<Shelter> shelters = [];
  int shelterIndex = 0;

  ShelterSingleton._internal();
}