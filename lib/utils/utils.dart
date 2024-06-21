import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../data_models/user_model.dart';



String getRoomId(String a, String b) {
  if (a.compareTo(b) > 0) {
    return a + b;
  } else {
    return b + a;
  }
}

void autoScroll(ScrollController scrollController) {
  Timer(const Duration(microseconds: 100), () {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(microseconds: 100), curve: Curves.easeOut);
  });
}

void autoScrollReverse(ScrollController scrollController) {
  Timer(const Duration(microseconds: 100), () {
    scrollController.animateTo(0,
        duration: const Duration(microseconds: 100), curve: Curves.easeOut);
  });
}


String createName(UserModel user) {
  return "${user.fullName} ${user.fullName}";
}