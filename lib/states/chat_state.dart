import 'package:get/get.dart';

import '../data_models/chat_info_model.dart';
import '../data_models/user_model.dart';

class ChatUserStateController extends GetxController {


  var selectedUser = UserModel(
          email: "email",
          uid: '',
          isblocked: true,
          rate: 12,
          review: '',
          photoURL: '',
          contactNumber: '',
          fullName: '', joinedOn: 0)
      .obs;
}

class ChatInfoStateController extends GetxController {
  var selectedUser = ChatInfo(
          friendName: "friendName",
          lastUpdated: 0,
          createDate: 0,
          friendId: "firstName",
          createName: "createName",
          lastMessage: "lastMessage",
          friendImage: "friendImage",
          createdImage: "createdImage",
          createId: "email")
      .obs;
}

class ChatUserStateControllerrefress extends GetxController {
  var shouldRefresh = false.obs;
}
