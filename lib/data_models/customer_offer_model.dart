import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomerOfferModel {
  String userId;
  String offerId;
  String description;
  String? serviceType;
  String? priceRange;
  DateTime? dateTime;
  LatLng? location;
  List<String>? offerImages;

  CustomerOfferModel({
    required this.userId,
    required this.offerId,
    required this.description,
    required this.location,
    this.serviceType,
    this.priceRange,
    this.dateTime,
    this.offerImages,
  });

  factory CustomerOfferModel.fromJson(Map<String, dynamic> json) {
    return CustomerOfferModel(
      userId: json['userId'],
      offerId: json['offerId'],
      description: json['description'],
      serviceType: json['serviceType'],
      priceRange: json['priceRange'],
      offerImages: json['offerImages'] != null
          ? List<String>.from(json['offerImages'])
          : null,
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
      'userId': userId,
      'offerId': offerId,
      'description': description,
      'serviceType': serviceType,
      'priceRange': priceRange,
      'dateTime': dateTime?.toIso8601String(),
    };

    if (offerImages != null) {
      data['offerImages'] = offerImages;
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
