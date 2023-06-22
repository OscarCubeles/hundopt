import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hundopt/shared/utils/date_formatter.dart';
import '../../models/chat.dart';
import '../../models/dog.dart';
import '../../models/message.dart';

///  The [ChatRepository] class provides methods for managing chat documents in Firestore.
class ChatRepository {
  /// Collection reference to the 'chats' collection in Firestore.
  final CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');

  /// Creates a new chat in the database with the specified details.
  ///
  /// The [shelterID], [userID], [dogID], [lastMessageDate], and [messages] parameters are used to construct
  /// the chat data. The [messages] list is converted into a list of map representations using the `toMap()`
  /// method of the [Message] class.
  ///
  /// Throws an exception if the chat creation fails.
  Future<void> createChat(
    String shelterID,
    String userID,
    String dogID,
    String lastMessageDate,
    List<Message> messages,
  ) async {
    Map<String, dynamic> chatData = {
      'shelterID': shelterID,
      'userID': userID,
      'dogID': dogID,
      'lastMessageDate': lastMessageDate,
      'messages': messages.map((message) => message.toMap()).toList(),
    };
    await chatsCollection.add(chatData);
  }

  /// Fetches the list of user chats from the database based on the specified [userID].
  ///
  /// The method retrieves the chat documents from the 'chats' collection where the 'userID' field matches
  /// the specified [userID]. It then converts the documents into [Chat] objects using the [Chat.fromMap] method
  /// and assigns them to an observable list. The list is returned as a [Future].
  ///
  /// Returns an [RxList<Chat>] containing the user's chats retrieved from the database.
  Future<RxList<Chat>> fetchUserChats(String userID) async {
    final userChats = <Chat>[].obs;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .where('userID', isEqualTo: userID)
        .get();
    final chats = querySnapshot.docs
        .map((doc) => Chat.fromMap(doc.id, doc.data()))
        .toList();
    userChats.assignAll(chats);
    return userChats;
  }

  /// Fetches a chat from the database based on the specified [userID] and [dogID].
  ///
  /// The method retrieves the chat document from the 'chats' collection where the 'userID' field matches
  /// the specified [userID] and the 'dogID' field matches the specified [dogID]. If a single document is found,
  /// it is converted into a [Chat] object using the [Chat.fromMap] method and returned as a [Future]. If no
  /// document is found or multiple documents are found, an empty [Chat] object is returned.
  ///
  /// Returns a [Chat] object retrieved from the database, or an empty [Chat] object if not found.
  Future<Chat> fetchChatByUserAndDogIDs(String userID, String dogID) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .where('userID', isEqualTo: userID)
        .where('dogID', isEqualTo: dogID)
        .get();
    if (querySnapshot.size == 1) {
      final chatData = querySnapshot.docs.first.data();
      final chatID = querySnapshot.docs.first.id;
      return Chat.fromMap(chatID, chatData);
    } else {
      return Chat.empty();
    }
  }

  /// Uploads the modified [chat] object to the database.
  ///
  /// The [userID] and [shelterID] parameters are used to determine the document ID of the chat to be updated.
  /// The [lastMessageDate] of the [chat] object is modified using the [DateFormatter.currTime] method. The modified
  /// [chat] object is converted into a map representation using the [Chat.toMap] method and uploaded to the 'chats'
  /// collection in the Firestore database.
  ///
  /// Throws an exception if the chat upload fails.
  Future<void> uploadChat(String userID, String shelterID, Chat chat) async {
    Chat modifiedChat = chat;
    modifiedChat.lastMessageDate = DateFormatter().currTime();
    try {
      final firestore = FirebaseFirestore.instance;
      Map<String, dynamic> chatData = modifiedChat.toMap();
      await firestore
          .collection('chats')
          .doc(modifiedChat.chatID)
          .set(chatData);
    } catch (e) {
      print('Failed to upload chat: $e');
    }
  }

  /// Gets an existing chat from the database based on the specified [userID] and [dog].
  ///
  /// The method retrieves a single chat document from the 'chats' collection where the 'userID' field matches
  /// the specified [userID] and the 'dogID' field matches the ID of the specified [dog]. If a chat document
  /// is found, it is converted into a [Chat] object using the [Chat.fromMap] method and returned as a [Future].
  /// If no chat document is found, a new chat is created using the [createNewChat] method.
  ///
  /// Returns a [Chat] object retrieved from the database, or a new chat if not found.
  Future<Chat> getOrCreateChat(String userID, Dog dog) async {
    final chatSnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .where('userID', isEqualTo: userID)
        .where('dogID', isEqualTo: dog.id)
        .limit(1)
        .get();
    if (chatSnapshot.docs.isNotEmpty) {
      final chatData = chatSnapshot.docs.first.data();
      final chatID = chatSnapshot.docs.first.id;
      return Chat.fromMap(chatID, chatData);
    } else {
      return createNewChat(userID, dog);
    }
  }

  /// Creates a new chat in the database based on the specified [userID] and [dog].
  ///
  /// The method creates a new chat with empty message data and adds it to the 'chats' collection in the Firestore database.
  /// The [shelterID], [userID], [dogID], [lastMessageDate], and [messages] properties of the chat are populated with the
  /// specified values. The created chat is returned as a [Future].
  ///
  /// Returns a new [Chat] object created in the database.
  Future<Chat> createNewChat(String userID, Dog dog) async {
    final newChat = Chat(
        chatID: '',
        shelterID: dog.shelterID,
        userID: userID,
        dogID: dog.id,
        lastMessageDate: '',
        messages: []);
    await createChat(dog.shelterID, userID, dog.id, "", []);
    return newChat;
  }
}
