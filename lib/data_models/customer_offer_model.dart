import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomerOfferModel {
  String offerId;
  String description;
  String? serviceType;
  String? priceRange;
  DateTime? dateTime;
  LatLng? location;


  CustomerOfferModel({
    required this.location,

    required this.offerId,
    required this.description,
    this.serviceType,
    this.priceRange,
    this.dateTime,
  });

  factory CustomerOfferModel.fromJson(Map<String, dynamic> json) {
    return CustomerOfferModel(
      offerId: json['offerId'],
      description: json['description'],
      serviceType: json['serviceType'],
      priceRange: json['priceRange'],
      location: json['location'] != null
          ? LatLng(
        json['location']['latitude'] ?? 0.0,
        json['location']['longitude'] ?? 0.0,
      )
          : null,
      dateTime:
      json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'offerId': offerId,
      'description': description,
      'serviceType': serviceType,
      'priceRange': priceRange,
      'dateTime': dateTime?.toIso8601String(),
    };
    if (location != null) {
      data['location'] = {
        'latitude': location!.latitude,
        'longitude': location!.longitude,
      };
    }
    return data;
  }
}
