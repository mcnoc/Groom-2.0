import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProviderServiceModel {
  String userId = '';
  String serviceId = '';
  String description = '';
  String serviceType = '';
  int? servicePrice;
  LatLng? location;
  List<String>? serviceImages;

  ProviderServiceModel(
      {required this.userId,
      required this.serviceId,
      required this.description,
      required this.serviceType,
      this.servicePrice,
      this.location,
      this.serviceImages});

  factory ProviderServiceModel.fromJson(Map<String, dynamic> json) {
    return ProviderServiceModel(
      userId: "userId",
      serviceId: "serviceId",
      description: "description",
      serviceType: "serviceType",
      servicePrice: int.parse(json["servicePrice"].toString()),
      serviceImages: json['serviceImages'] != null
          ? List<String>.from(json['serviceImages'])
          : null,
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
      'userId': userId,
      'offerId': serviceId,
      'description': description,
      'serviceType': serviceType,
      'servicePrice': servicePrice,
    };

    if (serviceImages != null) {
      data['serviceImages'] = serviceImages;
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
