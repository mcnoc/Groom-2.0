import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../states/user_state.dart';
import '../utils/colors.dart';
import '../widgets/signup_screen_widgets/button.dart';
import '../widgets/signup_screen_widgets/textforminputfield.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  final ImageController imageController = Get.put(ImageController());
  TextEditingController providerEmailController = TextEditingController();
  TextEditingController providerFullNameContoller = TextEditingController();
  TextEditingController providerContactController = TextEditingController();
  TextEditingController providerLocation = TextEditingController();

  bool passwordVisible = true;
  bool passwordVisibleConfrim = true;
  String? selectedLocation;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => imageController.selectImage(),
                child: Stack(
                  children: [
                    Obx(() {
                      return CircleAvatar(
                        radius: 59,
                        backgroundImage: imageController.selectedImage.value != null
                            ? MemoryImage(imageController.selectedImage.value!)
                            : AssetImage('assets/person.png') as ImageProvider,
                      );
                    }),
                    Positioned(
                      bottom: -10,
                      left: 70,
                      child: IconButton(
                        onPressed: () => imageController.selectImage(),
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
                padding: const EdgeInsets.all(8.0),
                child: TextFormInputField(
                    controller: providerFullNameContoller,
                    hintText: "Full Name",
                    IconSuffix: Icons.person,
                    textInputType: TextInputType.text),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: TextFormInputField(
                    controller: providerContactController,
                    hintText: "Contact Number",
                    IconSuffix: Icons.contact_page,
                    textInputType: TextInputType.number),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: TextFormInputField(
                    controller: providerEmailController,
                    hintText: "Email Address",
                    IconSuffix: Icons.email,
                    textInputType: TextInputType.emailAddress),
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
                    onTap: () async {}),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
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
