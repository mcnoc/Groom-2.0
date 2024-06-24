
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProviderUserModel {
  String about = '',
      workDayFrom = '',
      workDayTo = '',
      addressLine = '';
  int createdOn = 0;

  LatLng? location;

  List<String>? providerImages;

  ProviderUserModel(
      {required this.about,
      required this.workDayFrom,
      required this.workDayTo,
      required this.location,
      required this.addressLine,
      required this.createdOn,

      this.providerImages,
      });

  ProviderUserModel.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    workDayFrom = json['workDayFrom'];
    workDayTo = json['workDayTo'];
    addressLine = json['addressLine'];
    createdOn = int.parse(json['createdOn'].toString());
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
    data['location']= {
    'latitude': location?.latitude,
    'longitude': location?.longitude,
    };
    return data;
  }
}
