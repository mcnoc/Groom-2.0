import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../data_models/provider_service_model.dart';
import '../data_models/user_model.dart';

class ProviderServiceFirebase {
  var _ref = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getUserName (String userId)async{
    String username = "";
    var source = await _ref.ref('users').child(userId).child("fullName").once();
  var  username1 = source.snapshot;
  return username;
  }

  Future<bool> writeServiceToFirebase(
      String serviceId, ProviderServiceModel providerServiceModel) async {
    try {
      await _ref
          .ref("providerServices")
          .child(serviceId)
          .set(providerServiceModel.toJson());
    } catch (e) {
      print(e);
    }

    return false;
  }

  Future<List<ProviderServiceModel>> getAllServices() async {
    List<ProviderServiceModel> lst = [];
    var source = await _ref.ref("providerServices").once();
    var data = source.snapshot;
    if (data.value != null) {
      data.children.forEach((e) {
        ProviderServiceModel? providerServiceModel =
            ProviderServiceModel.fromJson(
          jsonDecode(
            jsonEncode(e.value),
          ),
        );
        lst.add(providerServiceModel);
      });
    }

    return lst;
  }



  Future<List<ProviderServiceModel>> getAllServicesByUserId(
      String userId) async {
    List<ProviderServiceModel> lst = [];
    var source = await _ref
        .ref("providerServices")
        .orderByChild("userId")
        .equalTo(userId)
        .once();
    var data = source.snapshot;

    if (data.value != null) {
      data.children.forEach((e) {
        ProviderServiceModel? providerServiceModel =
            ProviderServiceModel.fromJson(
          jsonDecode(
            jsonEncode(e.value),
          ),
        );
        lst.add(providerServiceModel);
      });
    }

    return lst;
  }

  Future<String> uploadImage(File image, String userID) async {
    try {
      String fileName =
          'users/$userID/providerServiceImages/${DateTime.now().millisecondsSinceEpoch}.jpg';
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
