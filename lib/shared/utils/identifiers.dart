import 'package:uuid/uuid.dart';

class Identifiers{
  static String generateUUID() {
    var uuid = const Uuid();
    return uuid.v4();
  }
}