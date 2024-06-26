import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProviderUserModel {
  String about;
  String workDayFrom;
  String workDayTo;
  String addressLine;
  String providerType;
  int createdOn;
  String? salonTitle;
  List<String> providerServices;
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

  factory ProviderUserModel.fromJson(Map<String, dynamic> json) {
    return ProviderUserModel(
      about: json['about'] ?? '',
      workDayFrom: json['workDayFrom'] ?? '',
      workDayTo: json['workDayTo'] ?? '',
      providerType: json['providerType'] ?? '',
      addressLine: json['addressLine'] ?? '',
      createdOn: json['createdOn'] != null ? int.parse(json['createdOn'].toString()) : 0,
      salonTitle: json['salonTitle'],
      providerServices: List<String>.from(json['providerServices'] ?? []),
      providerImages: json['providerImages'] != null ? List<String>.from(json['providerImages']) : null,
      location: json['location'] != null
          ? LatLng(
        json['location']['latitude'] ?? 0.0,
        json['location']['longitude'] ?? 0.0,
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'about': about,
      'workDayFrom': workDayFrom,
      'workDayTo': workDayTo,
      'addressLine': addressLine,
      'createdOn': createdOn,
      'providerType': providerType,
      'providerServices': providerServices,
      'salonTitle': salonTitle,
    };
    if (providerImages != null) {
      data['providerImages'] = providerImages;
    }
    if (location != null) {
      data['location'] = {
        'latitude': location!.latitude,
        'longitude': location!.longitude,
      };
    }
    return data;
  }
}
