import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../utils/colors.dart';
import '../widgets/login_screen_widgets/save_button.dart';
import 'signup_screen.dart';

class CustomerAuthLogin extends StatefulWidget {
  const CustomerAuthLogin({super.key});

  @override
  State<CustomerAuthLogin> createState() => _CustomerAuthLoginState();
}


class _CustomerAuthLoginState extends State<CustomerAuthLogin> {
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  bool isGoogle = false;
  //Password
  bool showPassword = false;
  //Password Functions
  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword; // Toggle the showPassword flag
    });
  }

  String? temp;
  String? n;
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Welcome back,",
              style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text(
              "Glad to meet you again!, please login to use the app.",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: chatColor),
            ),
          ),
          Flexible(child: Container()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: InternationalPhoneNumberInput(
                hintText: "Phone Number",
                textStyle: TextStyle(fontSize: 23),
                onInputChanged: (PhoneNumber number) {
                  temp = number.dialCode;
                  print(number.phoneNumber);
                  n = number.phoneNumber;
                },
                onInputValidated: (bool value) {},
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                textAlign: TextAlign.start,
                initialValue: number,
                textFieldController: phoneController,
                formatInput: false,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SaveButtonCustomer(
                title: "Sign In",
                onTap: () async { }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/r.png"),
          ),
          isGoogle
              ? Center(
              child: CircularProgressIndicator(
                color: mainBtnColor,
              ))
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SocialLoginButton(
              backgroundColor: Colors.white,
              borderRadius: 50,
              buttonType: SocialLoginButtonType.google,
              onPressed: () async {  },
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Get.to(()=>UserSignup());
              },
              child: Text.rich(TextSpan(
                  text: 'Don’t have an account? ',
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'Join Now',
                      style: GoogleFonts.workSans(
                          color: mainBtnColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )
                  ])),
            ),
          ),
          Flexible(
              child: Container(
                height: 10,
              )),
        ],
      ),
    );
  }


}
