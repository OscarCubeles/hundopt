import 'message.dart';

class Chat {
  String chatID;
  String shelterID;
  String userID;
  String dogID;
  String lastMessageDate;
  List<Message> messages;

  Chat({
    required this.chatID,
    required this.shelterID,
    required this.userID,
    required this.dogID,
    required this.lastMessageDate,
    required this.messages,
  });

  Chat.empty()
      : chatID = '',
        shelterID = '',
        userID = '',
        dogID = '',
        lastMessageDate = '',
        messages = [];

  Map<String, dynamic> toMap() {
    return {
      'shelterID': shelterID,
      'userID': userID,
      'dogID': dogID,
      'lastMessageDate': lastMessageDate,
      'messages': messages.map((message) => message.toMap()).toList(),
    };
  }



  factory Chat.fromMap(String chatID, Map<String, dynamic> map) {
    List<dynamic> messagesData = map['messages'] ?? [];
    List<Message> messages = messagesData.map((message) => Message.fromMap(message)).toList();

    return Chat(
      chatID: chatID,
      shelterID: map['shelterID'] ?? '',
      userID: map['userID'] ?? '',
      dogID: map['dogID'] ?? '',
      lastMessageDate: map['lastMessageDate'] ?? '',
      messages: messages,
    );
  }
}