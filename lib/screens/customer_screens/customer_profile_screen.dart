import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/screens/provider_screens/provider_main_dashboard.dart';
import 'package:groom/states/user_state.dart';
import '../../utils/colors.dart';
import '../../widgets/login_screen_widgets/save_button.dart';
import '../login_screen.dart';
import '../provider_screens/provider_form_screen.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserStateController userStateController = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userStateController.homeUser.value.fullName,
                        textAlign: TextAlign.start,
                      ),
                      Text(userStateController.homeUser.value.email),
                      Text(userStateController.homeUser.value.contactNumber),
                      userStateController.homeUser.value.providerUserModel ==
                              null
                          ? GestureDetector(
                              onTap: () {
                                Get.to(() => ProviderFormPage());
                              },
                              child: Text(
                                "Become a Groomer",
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400, fontSize: 13),
                              ),
                            )
                          : SizedBox(
                              height: 40,
                              child: TextButton(
                                onPressed: () {
                                  print(userStateController
                                      .homeUser.value.providerUserModel!
                                      .toJson());
                                  Get.to(() => ProviderMainDashboard());
                                },
                                child: Text("Groomer portal"),
                              ),
                            ),
                    ],
                  ),
                  ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: userStateController.homeUser.value.photoURL,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: mainBtnColor,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "General",
                  style: GoogleFonts.workSans(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5496FB)),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: textformFillColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.post_add,
                      color: textformColor,
                    ),
                    title: Text(
                      "Service Request",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textformColor,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.edit,
                      color: textformColor,
                    ),
                    title: Text(
                      "Edit Profile",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textformColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Divider(
                      color: borderColor,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.payment,
                      color: textformColor,
                    ),
                    title: Text(
                      "Payment Method",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textformColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Divider(
                      color: borderColor,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.group,
                      color: textformColor,
                    ),
                    title: Text(
                      "Invite Friends",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textformColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Divider(
                      color: borderColor,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: mainBtnColor,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "About App",
                        style: GoogleFonts.workSans(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff5496FB)),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.privacy_tip,
                      color: textformColor,
                    ),
                    title: Text(
                      "Privacy Policy ",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textformColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Divider(
                      color: borderColor,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.copy_all,
                      color: textformColor,
                    ),
                    title: Text(
                      "Terms & Conditions ",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textformColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Divider(
                      color: borderColor,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.help,
                      color: textformColor,
                    ),
                    title: Text(
                      "Help & Support",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textformColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Divider(
                      color: borderColor,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.info,
                      color: textformColor,
                    ),
                    title: Text(
                      "About",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: textformColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButtonCustomer(
                  title: "Logout",
                  onTap: () {
                    _showLogoutConfirmationDialog(context);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const UserLoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
