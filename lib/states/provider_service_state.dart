import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:groom/data_models/provider_service_model.dart';
import 'package:groom/data_models/provider_user_model.dart';
import 'package:groom/data_models/user_model.dart';

class ProviderServiceState extends GetxController {
  var serviceCreate = ProviderServiceModel(
    userId: "userId",
    serviceId: "serviceId",
    description: "description",
    serviceType: "serviceType",
    location: LatLng(0, 0),
  ).obs;

  var selectedProvider = UserModel(
    uid: "userId",
    contactNumber: "serviceId",
    city: "description",
    country: "serviceType",
    state: "0",
    email: '',
    isblocked: false,
    photoURL: '',
    fullName: '',
    joinedOn: 2,
    providerUserModel: ProviderUserModel(
      about: '',
      workDayFrom: '',
      workDayTo: '',
      location: null,
      addressLine: '',
      createdOn: 0,
      providerType: '',
      providerImages: [],
      providerServices: [],
    ),
  ).obs;
}
