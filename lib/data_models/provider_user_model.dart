import 'package:groom/data_models/user_model.dart';

class ProviderUserModel extends UserModel {



  ProviderUserModel(
      {required super.uid,
      required super.email,
      required super.isblocked,
      required super.rate,
      required super.review,
      required super.photoURL,
      required super.contactNumber,
      required super.fullName,
      required super.joinedOn});
}
