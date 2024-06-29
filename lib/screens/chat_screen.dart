import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data_models/chat_info_model.dart';
import '../data_models/message_model.dart';
import '../data_models/user_model.dart';
import '../firebase/chat_firebase.dart';
import '../firebase/user_firebase.dart';
import '../states/chat_state.dart';
import '../utils/utils.dart';
import '../widgets/chat_screen_widgets/bubble_chat_widget.dart';

class ChatDetailScreen extends StatefulWidget {
  final String userId;
  final String friendId;

  ChatDetailScreen({super.key, required this.userId, required this.friendId});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  UserFirebase firebaseService = UserFirebase();

  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ChatUserStateController;
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: FutureBuilder(
            future: firebaseService.getUser(widget.friendId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                var friendUser = snapshot.data;
                return Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(18),
                            ),
                            color: Color(0xFF2B3454),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${friendUser?.fullName} ",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 8,
                            child: widget.friendId != null
                                ? FirebaseAnimatedList(
                                    controller: _scrollController,
                                    reverse: true,
                                    sort: (DataSnapshot a, DataSnapshot b) =>
                                        b.key!.compareTo(a.key!),
                                    query: loadChatContent(
                                        context,
                                        FirebaseAuth.instance.currentUser!.uid,
                                        widget.friendId),
                                    itemBuilder: (BuildContext context,
                                        DataSnapshot snapshot,
                                        Animation<double> animation,
                                        int index) {
                                      var chatContent = ChatMessage.fromJson(
                                        jsonDecode(
                                          jsonEncode(snapshot.value),
                                        ),
                                      );

                                      return SizeTransition(
                                        sizeFactor: animation,
                                        child: chatContent.picture != null
                                            ? chatContent.senderId ==
                                                    FirebaseAuth.instance
                                                        .currentUser?.uid
                                                ? bubbleImageFromUser(
                                                    chatContent)
                                                : bubbleImageToUser(chatContent)
                                            : chatContent.senderId ==
                                                    FirebaseAuth.instance
                                                        .currentUser?.uid
                                                ? bubbleTextFromUser(
                                                    chatContent,
                                                    friendUser?.photoURL ?? "")
                                                : bubbleTextToUser(chatContent),
                                      );
                                    },
                                  )
                                : const CircularProgressIndicator()),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Write your message here ",
                                        hintStyle: TextStyle(fontSize: 14)),
                                    controller: _textEditingController,
                                    keyboardType: TextInputType.multiline,
                                    expands: true,
                                    minLines: null,
                                    maxLines: null,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (_textEditingController.text
                                      .trim()
                                      .isNotEmpty) {
                                    UserModel? userModel = await firebaseService
                                        .getUser(FirebaseAuth
                                            .instance.currentUser!.uid);

                                    var estimatedServerTimeInMs =
                                        DateTime.now().millisecondsSinceEpoch;

                                    ChatMessage chatMessage = ChatMessage(
                                      timeStamp: estimatedServerTimeInMs,
                                      senderId: widget.friendId,
                                      name: friendUser!.fullName,
                                      content: _textEditingController.text,
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    );

                                    ChatInfo chatinfo = ChatInfo(
                                      lastUpdated:
                                          DateTime.now().millisecondsSinceEpoch,
                                      friendName:
                                          "${friendUser.fullName} ${friendUser.fullName}",
                                      friendId: widget.friendId,
                                      createId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      lastMessage: _textEditingController.text,
                                      createName: createName(userModel),
                                      friendImage: friendUser.photoURL,
                                      createdImage: userModel.photoURL,
                                      createDate:
                                          DateTime.now().millisecondsSinceEpoch,
                                    );

                                    await addChatMessage(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      chatMessage,
                                      widget.friendId,
                                    );

                                    _textEditingController.text = '';

                                    autoScrollReverse(_scrollController);

                                    await checkChatList(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      widget.friendId,
                                      chatinfo,
                                    );
                                  } else {
                                    // Show a message indicating that the content cannot be empty
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Message cannot be empty'),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.send),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return Text("no data ");
            }),
      ),
    );
  }

  loadChatContent(
      BuildContext context, String currentUserId, String ChatUserId) {
    var chatRef = FirebaseDatabase.instance
        .ref()
        .child("chat")
        .child(getRoomId(currentUserId, ChatUserId))
        .child("details");

    return chatRef;
  }
}
