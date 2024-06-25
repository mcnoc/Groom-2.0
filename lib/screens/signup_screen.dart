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
import 'package:csc_picker/csc_picker.dart';
import '../widgets/signup_screen_widgets/textforminputfield.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({super.key});

  @override
  State<UserSignupScreen> createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<UserSignupScreen> {
  final _formKey = GlobalKey<FormState>();

  UserStateController _userStateController = Get.put(UserStateController());
  bool isLoading = false;
  int? dateOfBirthInt;
  UserFirebase userFirebase = UserFirebase();
  String? countryValue;
  String? stateValue;
  String? cityValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
                child: TextFormField(
                  controller: _userStateController.providerFullNameContoller,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    suffixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
                child: TextFormField(
                  controller: _userStateController.providerEmailController,
                  decoration: InputDecoration(
                    hintText: "Email Address",
                    suffixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                  onTap: () => _userStateController.selectDate(context),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
                child: CSCPicker(
                  showCities: true,
                  showStates: true,
                  onCountryChanged: (country) {
                    countryValue = country;
                  },
                  onStateChanged: (state) {
                    stateValue = state;
                  },
                  onCityChanged: (city) {
                    cityValue = city;
                  },
                  countrySearchPlaceholder: "Search Country",
                  stateSearchPlaceholder: "Search State",
                  citySearchPlaceholder: "Search City",
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
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
                          if (_formKey.currentState!.validate()) {
                            // Custom validations
                            if (_userStateController.selectedImage.value ==
                                null) {

                              Get.snackbar("Error", "Please select an image");
                              return;
                            }
                            if (countryValue == null ||
                                stateValue == null ||
                                cityValue == null) {
                              Get.snackbar("Error",
                                  "Please select your country, state, and city");
                              return;
                            }
                            if (await userFirebase.checkIfPhoneExists(
                                    _userStateController
                                        .phoneController.text) !=
                                true) {
                              UserModel? userModel = UserModel(
                                  uid: "uid",
                                  fullName: _userStateController
                                      .providerFullNameContoller.text,
                                  email: _userStateController
                                      .providerEmailController.text,
                                  isblocked: false,
                                  country: countryValue!,
                                  state: stateValue!,
                                  city: cityValue!,
                                  photoURL: _userStateController
                                      .userImage
                                      .toString(),
                                  contactNumber:
                                      _userStateController.phoneController.text,
                                  joinedOn:
                                      DateTime.now().microsecondsSinceEpoch,
                                  dateOfBirth:
                                      _userStateController.dateOfBirthInt);
                              _userStateController.userInit.value = userModel;
                              Get.to(() => PinCodeVerificationScreen(
                                    phonenumbertext: _userStateController
                                        .phoneController.text,
                                    phoneNumber: _userStateController.n,
                                  ));
                            } else {
                              Get.dialog(
                                AlertDialog(
                                  title: Text("Registration Error"),
                                  content: Text(
                                      "Only one account can be linked to a phone Number please try again using a differnet number "),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.offAll(()=>UserLoginScreen());
                                      },
                                      child: Text("close"),
                                    ),
                                  ],
                                ),
                              );
                              print("phone exists");
                            }
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
