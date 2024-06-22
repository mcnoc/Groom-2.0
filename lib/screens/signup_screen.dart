import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/data_models/user_model.dart';
import 'package:groom/firebase/user_firebase.dart';
import 'package:groom/screens/login_screen.dart';
import 'package:groom/screens/phone_verification_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../states/user_state.dart';
import '../utils/colors.dart';
import '../widgets/signup_screen_widgets/button.dart';
import '../widgets/signup_screen_widgets/textforminputfield.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({super.key});

  @override
  State<UserSignupScreen> createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<UserSignupScreen> {
  UserStateController _userStateController = Get.put(UserStateController());
  bool isLoading = false;
  int? dateOfBirthInt;
  UserFirebase userFirebase = UserFirebase();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _userStateController.selectImage(),
                child: Stack(
                  children: [
                    Obx(() {
                      return CircleAvatar(
                        radius: 59,
                        backgroundImage:
                            _userStateController.selectedImage.value != null
                                ? MemoryImage(
                                    _userStateController.selectedImage.value!)
                                : AssetImage('assets/person.png')
                                    as ImageProvider,
                      );
                    }),
                    Positioned(
                      bottom: -10,
                      left: 70,
                      child: IconButton(
                        onPressed: () => _userStateController.selectImage(),
                        icon: Icon(
                          Icons.add_a_photo,
                          color: colorBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Hello User",
                  style: GoogleFonts.workSans(
                      fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Create your account for \n better Experience",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                      color: textformColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: TextFormInputField(
                    controller: _userStateController.providerFullNameContoller,
                    hintText: "Full Name",
                    IconSuffix: Icons.person,
                    textInputType: TextInputType.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: TextFormInputField(
                    controller: _userStateController.providerEmailController,
                    hintText: "Email Address",
                    IconSuffix: Icons.email,
                    textInputType: TextInputType.emailAddress),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
                child: TextFormField(
                  controller: _userStateController.dateOfBirthController,
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    hintText: "Date of Birth",
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _userStateController.selectDate(context),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 0.0),
                    child: InternationalPhoneNumberInput(
                      hintText: "Phone Number",
                      textStyle: TextStyle(fontSize: 16),
                      onInputChanged: (PhoneNumber number) {
                        _userStateController.temp = number.dialCode;
                        print(number.phoneNumber);
                        _userStateController.n = number.phoneNumber;
                      },
                      onInputValidated: (bool value) {},
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      textAlign: TextAlign.start,
                      initialValue: _userStateController.number,
                      textFieldController: _userStateController.phoneController,
                      formatInput: false,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: mainBtnColor,
                        ),
                      )
                    : SaveButton(
                        title: "SIGNUP",
                        onTap: () async {
                          if(userFirebase.checkIfPhoneExists(_userStateController.phoneController.text)!=true){
                            UserModel? userModel = UserModel(
                                uid: "uid",
                                email: _userStateController
                                    .providerEmailController.text,
                                isblocked: false,
                                photoURL: _userStateController.selectedImage.value
                                    .toString(),
                                contactNumber:
                                _userStateController.phoneController.text,
                                fullName: _userStateController
                                    .providerFullNameContoller.text,
                                joinedOn: DateTime.now().microsecondsSinceEpoch,
                                dateOfBirth: _userStateController.dateOfBirthInt);
                            _userStateController.userInit.value = userModel;
                            Get.to(() => PinCodeVerificationScreen(
                              phonenumbertext:
                              _userStateController.phoneController.text,
                              phoneNumber: _userStateController.n,
                            ));

                          }else{
                            print("phone exists");
                          }

                        }),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text.rich(TextSpan(
                    text: 'Already have an account? ',
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Sign In',
                        style: GoogleFonts.workSans(
                            color: mainBtnColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
