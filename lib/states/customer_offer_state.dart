import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:groom/data_models/customer_offer_model.dart';

class CustomerOfferStateController extends GetxController {
  var offerCreate = CustomerOfferModel(
          userId: "",
          offerId: "",
          description: "",
          serviceType: "",
          priceRange: "",
          location: LatLng(0, 0),
          dateTime: DateTime.now())
      .obs;
}
