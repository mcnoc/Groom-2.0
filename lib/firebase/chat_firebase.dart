

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../data_models/chat_info_model.dart';
import '../data_models/message_model.dart';
import '../utils/utils.dart';

Future<bool> checkChatList(
    String currentUserId, String chatUserId, ChatInfo chatInfo) async {
  try {
    final snapshot = await FirebaseDatabase.instance
        .ref()
        .child("chatlist")
        .child(currentUserId)
        .child(chatUserId)
        .once();
    if (snapshot.snapshot.value != null) {
      await createChat(currentUserId, chatUserId, chatInfo);
    } else {
      await appendChat(currentUserId, chatUserId, chatInfo);
    }
    return false;
  } catch (error) {
    print('Error checking application: $error');
    return false;
  }
}

Future<bool> createChat(
    String currentUserId, String chatUserId, ChatInfo chatInfo) async {
  try {
    await FirebaseDatabase.instance
        .ref()
        .child("chatlist")
        .child(currentUserId)
        .child(chatUserId)
        .set(chatInfo.toJson());

    await FirebaseDatabase.instance
        .ref()
        .child("chatlist")
        .child(chatUserId)
        .child(currentUserId)
        .set(chatInfo.toJson());

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> appendChat(
    String currentUserId, String chatUserId, ChatInfo chatInfo) async {
  try {
    await FirebaseDatabase.instance
        .ref()
        .child("chatlist")
        .child(chatUserId)
        .child(currentUserId)
        .update(chatInfo.toJson());

    await FirebaseDatabase.instance
        .ref()
        .child("chatlist")
        .child(currentUserId)
        .child(chatUserId)
        .update(chatInfo.toJson());

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<List<ChatInfo>> getChatListByUserId(String userId) async {
  var list = <ChatInfo>[];
  var source = await FirebaseDatabase.instance
      .ref()
      .child('chatlist')
      .child(userId)
      .once();
  var values = source.snapshot.value;
  ChatInfo chatInfo;

  if (values is Map) {
    values.forEach((key, value) {
      chatInfo = ChatInfo.fromJson(Map<String, dynamic>.from(value));
      chatInfo.createId = key;
      list.add(chatInfo);
    });
  }

  return list;
}

Future<bool> addChatMessage(
    String currentUserId,
    ChatMessage chatMessage,
    String friendId,
    ) async {
  try {
    await FirebaseDatabase.instance
        .ref()
        .child("chat")
        .child(getRoomId(
        FirebaseAuth.instance.currentUser!.uid, friendId))
        .child("details")
        .push()
        .set(chatMessage.toJson());
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}


Future<List<ChatMessage>> getChatHistory(String roomId) async{


  var list = <ChatMessage>[];
  var source = await FirebaseDatabase.instance
      .ref()
      .child('chatlist')
      .child(roomId)
      .once();
  var values = source.snapshot.value;
  ChatMessage chatMessage;

  if (values is Map) {
    values.forEach((key, value) {
      chatMessage = ChatMessage.fromJson(Map<String, dynamic>.from(value));
      chatMessage.uid = key;
      list.add(chatMessage);
    });
  }

  return list;
}
