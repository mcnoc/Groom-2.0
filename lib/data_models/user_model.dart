import 'package:groom/data_models/provider_user_model.dart';

class UserModel {
  String uid;
  String email;
  String fullName;
  String photoURL;
  String contactNumber;
  bool isblocked;
  int joinedOn;
  int? dateOfBirth;
  String country, state, city;
  ProviderUserModel? providerUserModel;

  UserModel({
    required this.uid,
    required this.email,
    required this.isblocked,
    required this.photoURL,
    required this.contactNumber,
    required this.fullName,
    required this.joinedOn,
    required this.dateOfBirth,
    required this.country,
    required this.state,
    required this.city,
    this.providerUserModel,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'isblocked': isblocked,
        'uid': uid,
        'email': email,
        'contactNumber': contactNumber,
        'photoURL': photoURL,
        'joinedOn': joinedOn,
        'dateOfBirth': dateOfBirth,
        'country': country,
        'state': state,
        'city': city,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      uid: json['uid'],
      isblocked: json['isblocked'],
      email: json['email'],
      photoURL: json['photoURL'],
      contactNumber: json['contactNumber'],
      joinedOn: json['joinedOn'],
      dateOfBirth: json['dateOfBirth'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
    );
  }
}
