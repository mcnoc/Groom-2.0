import 'package:groom/data_models/provider_user_model.dart';

import 'favorite_model.dart';

class UserModel {
  String uid;
  String email;
  String fullName;
  String photoURL;
  String contactNumber;
  bool isblocked;
  int joinedOn;
  int? dateOfBirth;
  String country;
  String state;
  String city;
  ProviderUserModel? providerUserModel;
  List<String>? favorites;

  UserModel({
    required this.uid,
    required this.email,
    required this.isblocked,
    required this.photoURL,
    required this.contactNumber,
    required this.fullName,
    required this.joinedOn,
    this.dateOfBirth,
    required this.country,
    required this.state,
    required this.city,
    this.providerUserModel,
    this.favorites,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'] ?? '',
        email: json['email'] ?? '',
        fullName: json['fullName'] ?? '',
        photoURL: json['photoURL'] ?? '',
        contactNumber: json['contactNumber'] ?? '',
        isblocked: json['isblocked'] ?? false,
        joinedOn: json['joinedOn'] != null
            ? int.parse(json['joinedOn'].toString())
            : 0,
        dateOfBirth: json['dateOfBirth'] != null
            ? int.parse(json['dateOfBirth'].toString())
            : null,
        country: json['country'] ?? '',
        state: json['state'] ?? '',
        city: json['city'] ?? '',
        providerUserModel: json['providerUserModel'] != null &&
                json['providerUserModel'] is Map<String, dynamic>
            ? ProviderUserModel.fromJson(json['providerUserModel'])
            : null,
        favorites: json['favorites'] != null
            ? List<String>.from(json['favorites'])
            : null);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'photoURL': photoURL,
      'contactNumber': contactNumber,
      'isblocked': isblocked,
      'joinedOn': joinedOn,
      'dateOfBirth': dateOfBirth,
      'country': country,
      'state': state,
      'city': city,
    };
    if (favorites != null) {
      data['favorites'] = favorites;
    }
    if (providerUserModel != null) {
      data['providerUserModel'] = providerUserModel!.toJson();
    }
    return data;
  }
}
