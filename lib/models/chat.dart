import 'message.dart';

/// The [Chat] class models a Chat object.
class Chat {
  String chatID;
  String shelterID;
  String userID;
  String dogID;
  String lastMessageDate;
  List<Message> messages;

  /// Constructs a new instance of the [Chat] class with the specified parameters.
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

  /// Converts the [Chat] object to a Map.
  Map<String, dynamic> toMap() {
    return {
      'shelterID': shelterID,
      'userID': userID,
      'dogID': dogID,
      'lastMessageDate': lastMessageDate,
      'messages': messages.map((message) => message.toMap()).toList(),
    };
  }

  /// Constructs a [Chat] object from a Map.
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
