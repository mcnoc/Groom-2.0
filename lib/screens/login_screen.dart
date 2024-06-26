import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/states/user_state.dart';
import 'package:groom/view_models/login_screen_view/login_screen_vm_imp.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../firebase/auth_service_firebase.dart';
import '../main.dart';
import '../utils/colors.dart';
import '../widgets/login_screen_widgets/save_button.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  UserStateController userStateController = Get.put(UserStateController());
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  bool isGoogle = false;
  String? temp;
  String? n;
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  final viewModel = LoginScreenViewModelImp();
  final AuthService _authService = AuthService();


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
              "Welcome to Groom,",
              style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text(
              "Please login to use the app.",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w500, fontSize: 14, color: chatColor),
            ),
          ),
          Flexible(child: Container()),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: InternationalPhoneNumberInput(
                hintText: "Phone Number",
                textStyle: TextStyle(fontSize: 23),
                onInputChanged: (PhoneNumber number) {
                  temp = number.dialCode;
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButtonCustomer(
                title: "Sign In",
                onTap: () async {
                  if (await viewModel.checkUserPhone(
                          context, phoneController.text) !=
                      true) {
                    Get.dialog(
                      AlertDialog(
                        title: Text("Phone Number is not Registed"),
                        content: Text("Please Sign Up for a new account"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Close"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    viewModel.navigatePinCode(context, phoneController.text, n!);

                  }
                },
              ),
            ),
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
                    onPressed: () async {

                      User? user = await _authService.signInWithGoogle();
                      if (user != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Signed in as ${user.displayName}")),
                        );
                        Get.offAll(()=>AuthenticationWrapper());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Sign-in failed")),
                        );
                      }


                    },
                  ),
                ),
          Center(
            child: GestureDetector(
              onTap: () {
                viewModel.navigateSignUp(context);
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
