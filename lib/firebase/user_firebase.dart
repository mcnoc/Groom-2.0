import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../data_models/user_model.dart';


class UserFirebase {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  Future<void> addUser(UserModel user) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child('users').child(currentUser.uid);
      await userRef.set(user.toJson());
    } else {
      print(
          "User is not logged in"); // Handle the case where the user is not logged in
    }
  }

  Future<UserModel> getUser(String UserId) async {
    var source = await FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(UserId)
        .once();
    var values = source.snapshot;
    UserModel? userModel;
    userModel = UserModel.fromJson(
      jsonDecode(
        jsonEncode(values.value),
      ),
    );

    return userModel;
  }

  Future<String?> getImage(String UserId) async {
    String? imageurl = "";
    var source = await FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(UserId)
        .once();
    var value = source.snapshot;
    UserModel? userModel;
    return imageurl;
  }

  Future<bool> updateUserFile(String userId) async {
    try {
      var source = await FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(userId)
          .once();
      var value = source.snapshot;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> checkIfPhoneExists(String phoneNumber) async {
    try {
      final source = await _databaseReference
          .child('users')
          .orderByChild("phoneNumber")
          .equalTo(phoneNumber)
          .once();
      var results = source.snapshot;
      if (results.value != null) {
        return true;
      }
      return false;
    } catch (error) {
      print('Error checking application: $error');
      return false;
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    try {
      final source = await _databaseReference
          .child('users')
          .orderByChild("email")
          .equalTo(email)
          .once();
      var results = source.snapshot;
      if (results.value != null) {
        return true;
      }
      return false;
    } catch (error) {
      print('Error checking application: $error');
      return false;
    }
  }
}