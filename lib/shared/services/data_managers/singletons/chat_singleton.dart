import '../../../../models/chat.dart';

/// The [ChatSingleton] class stores the current chat.
class ChatSingleton {
  /// The instance of the `ChatSingleton` class.
  static final ChatSingleton _instance = ChatSingleton._internal();

  /// Returns the instance of the `ChatSingleton` class.
  factory ChatSingleton() => _instance;

  /// The current chat.
  Chat chat = Chat.empty();

  /// Private constructor for the `ChatSingleton` class.
  ChatSingleton._internal();
}
