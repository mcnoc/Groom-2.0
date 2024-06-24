import 'package:groom/data_models/user_model.dart';

import 'booking_model.dart';

class ClientUserModel {
  String clientAddress = '';

  List<BookingModel> clientBookings = [];

  ClientUserModel({required this.clientAddress, required this.clientBookings});

  ClientUserModel.fromJson(Map<String,dynamic>json){
    clientAddress = json['clientAddress'];
    if (json['clientBookings'] != null) {
      clientBookings = List<BookingModel>.empty(growable: true);
      json['clientBookings'].forEach((v) {
        clientBookings.add(BookingModel.fromJson(v));
      });
    }
  }
}
