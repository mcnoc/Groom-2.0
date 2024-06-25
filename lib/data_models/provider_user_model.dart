import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProviderUserModel {
  String about = '',
      workDayFrom = '',
      workDayTo = '',
      addressLine = '',
      providerType = '';
  int createdOn = 0;
  String? salonTitle;
  List<String> providerServices=[];
  LatLng? location;
  List<String>? providerImages;

  ProviderUserModel({
    required this.about,
    required this.workDayFrom,
    required this.workDayTo,
    required this.location,
    required this.addressLine,
    required this.createdOn,
    required this.providerType,
    required this.providerServices,
    this.providerImages,
    this.salonTitle,
  });

  ProviderUserModel.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    workDayFrom = json['workDayFrom'];
    workDayTo = json['workDayTo'];
    providerType = json['providerType'];
    addressLine = json['addressLine'];
    createdOn = int.parse(json['createdOn'].toString());
    salonTitle = json['salonTile'];
    providerServices = List<String>.from(json['providerServices'] ?? []);

    location = LatLng(
      json['location']['latitude'],
      json['location']['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['workDayFrom'] = workDayFrom;
    data['workDayTo'] = workDayTo;
    data['location'] = location;
    data['addressLine'] = addressLine;
    data['createdOn'] = createdOn;
    data['salonTitle'] = salonTitle;
    data['providerServices'] = providerServices;
    data['providerType'] = providerType;
    data['location'] = {
      'latitude': location?.latitude,
      'longitude': location?.longitude,
    };
    return data;
  }
}
