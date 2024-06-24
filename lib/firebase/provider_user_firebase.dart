import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:groom/data_models/provider_user_model.dart';
import 'package:groom/data_models/user_model.dart';

class ProviderUserFirebase {
  var _auth = FirebaseDatabase.instance;

  Future<bool> addProvider(
      String userID, ProviderUserModel providerModel) async {
    try {
      await _auth
          .ref("users")
          .child(userID)
          .child("providerUserModel")
          .update(providerModel.toJson());
      return true;
    } catch (e) {
      print(e);
    }

    return false;
  }

  Future<List<UserModel>> getAllProviders() async {
    List<UserModel> provideList = [];
    var source = await _auth
        .ref("users")
        .once();
    var snapshot = source.snapshot;
    UserModel? userModel;
    if (snapshot.value != null) {
      snapshot.children.forEach((element) {
        userModel = UserModel.fromJson(jsonDecode(jsonEncode(element.value)));
        userModel!.uid = element.key!;
        provideList.add(userModel!);
      });
    }
    return provideList;
  }
}
