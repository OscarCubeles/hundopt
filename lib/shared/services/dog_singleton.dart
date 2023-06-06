import '../../models/dog.dart';

class DogSingleton {
  static final DogSingleton _instance = DogSingleton._internal();
  factory DogSingleton() => _instance;

  List<Dog>? dogs;
  int? dogIndex;

  DogSingleton._internal();
}