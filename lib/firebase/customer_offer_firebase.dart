import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:groom/data_models/customer_offer_model.dart';

class CustomerOfferFirebase {
  var _ref = FirebaseDatabase.instance;

  Future<bool> WriteOfferToFirebase(
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

  Future<List<CustomerOfferModel>> GetAllOffers() async {
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
}
