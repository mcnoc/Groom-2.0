import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groom/data_models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../utils/custome_utils.dart';

class UserStateController extends GetxController {


  File? userImage;
  var selectedImage = Rxn<Uint8List>();
  String? temp;
  String? n;
  int? dateOfBirthInt;
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController providerEmailController = TextEditingController();
  TextEditingController providerFullNameContoller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'US');

  var userInit = UserModel(
    uid: "uid",
    email: "email",
    isblocked: false,
    photoURL: "photoURL",
    contactNumber: "",
    fullName: "fullName",
    dateOfBirth: 0,
    joinedOn: 2,
    country: "",
    state: "",
    city: "",
  ).obs;

  void selectImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = await pickedFile.readAsBytes();
      userImage = File(pickedFile.path);

    }
  }


  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirthController.text = "${picked.toLocal()}".split(' ')[0];
      dateOfBirthInt = int.parse(
          "${picked.year}${picked.month.toString().padLeft(2, '0')}${picked.day.toString().padLeft(2, '0')}");
    }
  }
  @override
  void onClose() {
    dateOfBirthController.dispose();
    providerEmailController.dispose();
    providerFullNameContoller.dispose();
    phoneController.dispose();
    super.onClose();
  }


}
