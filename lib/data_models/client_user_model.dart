import 'package:groom/data_models/user_model.dart';

class ClientUserModel extends UserModel {

    String clientAddress ;



  ClientUserModel(
      {required super.uid,
      required super.email,
      required super.isblocked,
      required super.photoURL,
      required super.contactNumber,
      required super.fullName,
      required super.joinedOn,
      required this.clientAddress, required super.dateOfBirth,
      });
}
