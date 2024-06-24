import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groom/firebase/user_firebase.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../data_models/user_model.dart';
import '../states/user_state.dart';
import 'customer_home_screen.dart';
import 'customer_main_dashboard.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String? phoneNumber;
  final String phonenumbertext;

  PinCodeVerificationScreen({
    super.key,
    this.phoneNumber,
    required this.phonenumbertext,
  });

  @override
  State<PinCodeVerificationScreen> createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  final UserStateController userStateController = Get.find();
  TextEditingController textEditingController = TextEditingController();
  final UserFirebase userService = UserFirebase();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  String? smscode;
  int? token;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    registerUser(widget.phoneNumber!);
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    child: Column(
                      children: [
                        Text(
                          "Enter Verification Code",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              color: Colors.deepOrange),
                        ),
                        Text(
                            "Please enter code sent to ${widget.phonenumbertext}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.deepOrange)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.red.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 3) {
                              return "I'm from validator";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            activeColor: const Color(0xff00ce70),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            print("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError ? "*Please fill up all the cells properly" : "",
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't Receive code ?",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () => snackBar("OTP resend!!"),
                          child: const Text(
                            "Resent Code",
                            style: TextStyle(
                                color: Color(0xFF91D3B3),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 30),
                    decoration: BoxDecoration(
                        color: Colors.red.shade300,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.red.shade200,
                              offset: const Offset(1, -2),
                              blurRadius: 5),
                          BoxShadow(
                              color: Colors.red.shade200,
                              offset: const Offset(-1, 2),
                              blurRadius: 5)
                        ]),
                    child: ButtonTheme(
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          // conditions for validating
                          if (currentText.length != 6) {
                            errorController!.add(ErrorAnimationType
                                .shake); // Triggering error shake animation
                            setState(() => hasError = true);
                          } else {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            await auth.signInWithCredential(
                              PhoneAuthProvider.credential(
                                  verificationId: smscode!,
                                  smsCode: currentText),
                            );
                            bool numberExists = await userService
                                .checkIfPhoneExists(widget.phonenumbertext);

                            if (FirebaseAuth.instance.currentUser != null) {
                              if (numberExists) {
                                Get.offAll(() => CustomerMainDashboard());
                              } else {
                                UserModel userModel =
                                    userStateController.userInit.value;
                                userModel.uid =
                                    FirebaseAuth.instance.currentUser!.uid;

                                try {
                                  var photoURL = await userService.uploadImage(
                                      userStateController.userImage!,
                                      FirebaseAuth.instance.currentUser!.uid);
                                  userModel.photoURL = photoURL;

                                  await userService.addUser(userModel);
                                  Get.offAll(() => CustomerMainDashboard());
                                } catch (e) {
                                  Get.snackbar('ALERT', 'INVALID PHONE NUMBER');

                                  print(e);
                                  print("Error adding user");
                                }
                              }
                            } else {
                              Get.dialog(
                                AlertDialog(
                                  title: const Text('Error'),
                                  content:
                                      const Text('Phone is not registered.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: const Center(
                            child: Text(
                          "VERIFY",
                          style: TextStyle(
                            color: Colors.deepOrange,
                          ),
                        )),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Color(0xFF2B3454)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.01,
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future registerUser(String mobile) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) async {
          _auth.signInWithCredential(authCredential).then((result) async {
            print('successful i guess');
            printInfo(info: result.toString());

            if (FirebaseAuth.instance.currentUser != null) {}
          }).catchError((e) {
            print('theres an error probably');
            printError(info: e);
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          print('verification failed i think');
          Get.snackbar('ALERT', authException.message.toString());
          Get.back();
          printInfo(info: authException.message!);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          smscode = verificationId;
          token = forceResendingToken;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Get.snackbar("Timeout", "OTP code is Expired");
        });
  }
}
