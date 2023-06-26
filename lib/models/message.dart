/// The [Message] class models a Message object used in chats.
class Message {
  /// The text of the message.
  String text;

  /// The date of the message.
  String date;

  /// Whether the message was sent by the user or not.
  bool isUser;

  /// Constructs a new instance of the [Message] class with the specified parameters.
  ///
  /// The [text], [date], and [isUser] parameters must not be null.
  Message({
    required this.text,
    required this.date,
    required this.isUser,
  });

  /// Converts the [Message] object to a JSON-compatible Map.
  ///
  /// Returns a Map representing the [Message] object in a format that can be
  /// easily serialized to JSON. The keys in the map are the field names of the
  /// [Message] class, and the values are the corresponding values of the fields.
  /// The fields included in the map are 'text', 'date', and 'isUser'.
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'date': date,
      'isUser': isUser,
    };
  }

  /// Constructs a new instance of the [Message] class from a [Map] of key-value pairs.
  ///
  /// The [map] parameter must not be null.
  ///
  /// The returned [Message] instance will have its fields populated with the values from the [map] parameter.
  /// If a key is not present in the [map], the corresponding field will be initialized to a default value.
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] ?? '',
      date: map['date'] ?? '',
      isUser: map['isUser'] ?? false,
    );
  }
}
