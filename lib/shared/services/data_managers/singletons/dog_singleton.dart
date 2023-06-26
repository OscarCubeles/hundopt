import '../../../../models/dog.dart';

/// The [DogSingleton] singleton class  stores the list of dogs and the index of the current dog.
class DogSingleton {
  /// The instance of the `DogSingleton` class.
  static final DogSingleton _instance = DogSingleton._internal();

  /// Returns the instance of the `DogSingleton` class.
  factory DogSingleton() => _instance;

  /// The list of dogs.
  List<Dog>? dogs;

  /// The index of the current dog.
  int? dogIndex;

  /// Private constructor for the `DogSingleton` class.
  DogSingleton._internal();
}
