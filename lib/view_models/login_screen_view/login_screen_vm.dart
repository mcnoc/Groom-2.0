
import 'package:flutter/material.dart';

abstract class LoginScreenViewModel {

  void userLogin(BuildContext context);
  void navigateSignUp(BuildContext context);
  void navigatePinCode(BuildContext context,String phoneText,String phoneNumber);
  Future<bool> checkUserPhone(BuildContext context,String phoneNumber);


}