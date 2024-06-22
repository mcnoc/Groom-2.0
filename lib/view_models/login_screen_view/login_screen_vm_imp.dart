import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:groom/firebase/user_firebase.dart';
import 'package:groom/screens/signup_screen.dart';
import 'package:groom/view_models/login_screen_view/login_screen_vm.dart';

import '../../screens/phone_verification_screen.dart';

class LoginScreenViewModelImp implements LoginScreenViewModel{

  UserFirebase userFirebase = UserFirebase();
  @override
  void navigateSignUp(BuildContext context) {
    Get.to(()=>UserSignupScreen());
  }

  @override
  void userLogin(BuildContext context) {
  }

  @override
  Future<bool> checkUserPhone(BuildContext context,String phoneNumber) async {

    return await userFirebase.checkIfPhoneExists(phoneNumber) ? false : true;
  }

  @override
  void navigatePinCode(BuildContext context, String phoneText, String phoneNumber) {

    Get.to(
          () => PinCodeVerificationScreen(
        phonenumbertext: phoneText,
        phoneNumber: phoneNumber,
      ),
    );
  }

}