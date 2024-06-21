import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:groom/data_models/user_model.dart';

import '../utils/custome_utils.dart';

class ImageController extends GetxController {
  var selectedImage = Rxn<Uint8List>();

  void selectImage() async {
    Uint8List? image = await CustomUtilities.pickImageFromGallery();
    if (image != null) {
      selectedImage.value = image;
    }
  }
}

class UserStateController extends GetxController {
  var userInit = UserModel(
          uid: "uid",
          email: "email",
          isblocked: true,
          rate: 2,
          review: "review",
          photoURL: "photoURL",
          contactNumber: "",
          fullName: "fullName",
          joinedOn: 2)
      .obs;


}
