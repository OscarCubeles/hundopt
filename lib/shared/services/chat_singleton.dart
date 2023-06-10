import '../../models/chat.dart';

class ChatSingleton {
  static final ChatSingleton _instance = ChatSingleton._internal();
  factory ChatSingleton() => _instance;

  Chat chat = Chat.empty();

  ChatSingleton._internal();
}