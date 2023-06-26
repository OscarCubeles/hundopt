import 'message.dart';

/// The [Chat] class models a Chat object.
class Chat {
  /// The ID of the chat.
  String chatID;

  /// The ID of the shelter.
  String shelterID;

  /// The ID of the user.
  String userID;

  /// The ID of the dog.
  String dogID;

  /// The date of the last message in the chat.
  String lastMessageDate;

  /// The list of messages in the chat.
  List<Message> messages;

  /// Constructs a new instance of the [Chat] class with the specified parameters.
  ///
  /// The [chatID], [shelterID], [userID], [dogID], [lastMessageDate], and [messages] parameters must not be null.
  Chat({
    required this.chatID,
    required this.shelterID,
    required this.userID,
    required this.dogID,
    required this.lastMessageDate,
    required this.messages,
  });

  /// Creates an empty [Chat] object.
  Chat.empty()
      : chatID = '',
        shelterID = '',
        userID = '',
        dogID = '',
        lastMessageDate = '',
        messages = [];

  /// Converts the [Chat] object to a JSON-compatible Map.
  ///
  /// Returns a Map representing the [Chat] object in a format that can be
  /// easily serialized to JSON. The keys in the map are the field names of the
  /// [Chat] class, and the values are the corresponding values of the fields.
  /// The included fields are 'shelterID', 'userID', 'dogID', 'lastMessageDate',
  /// and 'messages'.
  ///
  /// The 'shelterID', 'userID', and 'dogID' fields contain the IDs of the
  /// shelter, user, and dog associated with the chat. The 'lastMessageDate'
  /// field represents the date of the last message in the chat. The 'messages'
  /// field is a list of messages in the chat, where each message is represented
  /// as a JSON-compatible Map using the [Message.toMap()] method.
  Map<String, dynamic> toMap() {
    return {
      'shelterID': shelterID,
      'userID': userID,
      'dogID': dogID,
      'lastMessageDate': lastMessageDate,
      'messages': messages.map((message) => message.toMap()).toList(),
    };
  }

  /// Constructs a new instance of the [Chat] class from a [Map] of key-value pairs.
  ///
  /// The [chatID] parameter is the ID of the chat and must not be null.
  /// The [map] parameter must not be null.
  ///
  /// The returned [Chat] instance will have its fields populated with the values from the [map] parameter.
  /// If a key is not present in the [map], the corresponding field will be initialized to a default value.
  /// The `messages` field of the returned [Chat] instance will be populated with the messages from the `messages` key of the [map] parameter.
  /// If the `messages` key is not present in the [map], an empty list will be used instead.
  factory Chat.fromMap(String chatID, Map<String, dynamic> map) {
    List<dynamic> messagesData = map['messages'] ?? [];
    List<Message> messages =
        messagesData.map((message) => Message.fromMap(message)).toList();
    return Chat(
      chatID: chatID,
      shelterID: map['shelterID'] ?? '',
      userID: map['userID'] ?? '',
      dogID: map['dogID'] ?? '',
      lastMessageDate: map['lastMessageDate'] ?? '',
      messages: messages,
    );
  }

  /// Checks if the [Chat] object is empty.
  bool isEmpty() {
    return chatID.isEmpty &&
        shelterID.isEmpty &&
        userID.isEmpty &&
        dogID.isEmpty &&
        lastMessageDate.isEmpty &&
        messages.isEmpty;
  }
}
