import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/chat.dart';
import '../../models/message.dart';

class ChatRepository {
  final CollectionReference chatsCollection =
  FirebaseFirestore.instance.collection('chats');

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



  Future<RxList<Chat>> fetchUserChats(String userID) async {
    final userChats = <Chat>[].obs;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .where('userID', isEqualTo: userID)
        .get();

    final chats = querySnapshot.docs.map((doc) => Chat.fromMap(doc.id, doc.data())).toList();
    userChats.assignAll(chats);
    return userChats;
  }

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
      return Chat.empty(); // Chat not found or multiple matching chats
    }
  }
}