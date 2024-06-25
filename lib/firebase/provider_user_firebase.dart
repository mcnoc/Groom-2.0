import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:groom/data_models/provider_user_model.dart';
import 'package:groom/data_models/user_model.dart';

class ProviderUserFirebase {
  var _auth = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  Future<String> uploadImage(File image,String userID) async {
    try {
      String fileName = 'users/$userID/providerImages/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = _storage.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e);
      return '';
    }
  }
}
