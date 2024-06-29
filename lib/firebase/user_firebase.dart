import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../data_models/user_model.dart';

class UserFirebase {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
          .orderByChild("contactNumber")
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

  Future<String> uploadImage(File image, String userID) async {
    try {
      String fileName =
          'users/$userID/imageProfile/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = _storage.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<bool> addServiceToFavorites(String userId, String serviceId) async {
    try {
      var source = await _databaseReference.ref
          .child('users')
          .child(userId)
          .child("favorites")
          .once();

      var data = source.snapshot;
      List<String> currentFavorites = [];
      if (data.value != null) {
        currentFavorites = List<String>.from(data as List<dynamic>);
        if (!currentFavorites.contains(serviceId)) {
          currentFavorites.add(serviceId);
        }
        await _databaseReference.ref
            .child('users')
            .child(userId)
            .child('favorites')
            .set(currentFavorites);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> removeServiceToFavorites(String userId, String serviceId) async {
    try {
      var source = await _databaseReference.ref
          .child('users')
          .child(userId)
          .child("favorites")
          .once();

      var data = source.snapshot;
      List<String> currentFavorites = [];
      if (data.value != null) {
        currentFavorites = List<String>.from(data as List<dynamic>);
        if (!currentFavorites.contains(serviceId)) {
          currentFavorites.remove(serviceId);
        }
        await _databaseReference.ref
            .child('users')
            .child(userId)
            .child('favorites')
            .set(currentFavorites);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
