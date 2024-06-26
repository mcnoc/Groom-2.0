import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:groom/data_models/customer_offer_model.dart';

class CustomerOfferFirebase {
  var _ref = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;


  Future<bool> writeOfferToFirebase(
      String offerId, CustomerOfferModel customerOfferModel) async {
    try {
      await _ref
          .ref("customerOffers")
          .child(offerId)
          .set(customerOfferModel.toJson());
    } catch (e) {
      print(e);
    }

    return false;
  }

  Future<List<CustomerOfferModel>> getAllOffers() async {
    List<CustomerOfferModel> lst = [];
    var source = await _ref.ref("customerOffers").once();
    var data = source.snapshot;

    if (data.value != null) {
      data.children.forEach((e) {
        CustomerOfferModel? customerOfferModel = CustomerOfferModel.fromJson(
          jsonDecode(
            jsonEncode(e.value),
          ),
        );
        lst.add(customerOfferModel);
      });
    }

    return lst;
  }

  Future<List<CustomerOfferModel>> getAllOffersByUserId(String userId) async {
    List<CustomerOfferModel> lst = [];
    var source = await _ref
        .ref("customerOffers")
        .orderByChild("userId")
        .equalTo(userId)
        .once();
    var data = source.snapshot;

    if (data.value != null) {
      data.children.forEach((e) {
        CustomerOfferModel? customerOfferModel = CustomerOfferModel.fromJson(
          jsonDecode(
            jsonEncode(e.value),
          ),
        );
        lst.add(customerOfferModel);
      });
    }

    return lst;
  }
  Future<String> uploadImage(File image,String userID) async {
    try {
      String fileName = 'users/$userID/customerOfferImages/${DateTime.now().millisecondsSinceEpoch}.jpg';
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
