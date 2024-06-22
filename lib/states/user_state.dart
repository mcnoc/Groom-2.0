import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groom/data_models/user_model.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../utils/custome_utils.dart';


class UserStateController extends GetxController {


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
          isblocked: true,
          photoURL: "photoURL",
          contactNumber: "",
          fullName: "fullName",
          dateOfBirth: 0,
          joinedOn: 2)
      .obs;

  void selectImage() async {
    Uint8List? image = await CustomUtilities.pickImageFromGallery();
    if (image != null) {
      selectedImage.value = image;
    }
  }

  Future<void> selectDate (BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirthController.text = "${picked.toLocal()}".split(' ')[0];
      dateOfBirthInt = int.parse("${picked.year}${picked.month.toString().padLeft(2, '0')}${picked.day.toString().padLeft(2, '0')}");

    }
  }



}
