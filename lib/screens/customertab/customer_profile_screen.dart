import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../../widgets/login_screen_widgets/save_button.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Setting",
            style: GoogleFonts.workSans(
                color: colorwhite, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: mainBtnColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {   },
                child: Text(
                  "Become a Provider",
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400, fontSize: 13),
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
                      onTap: () {  },
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
                      onTap: () {  },
                      leading: Icon(
                        Icons.language_outlined,
                        color: textformColor,
                      ),
                      title: Text(
                        "Change Password",
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
                      onTap: () { },
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
                      onTap: () {  },
                      leading: Icon(
                        Icons.notifications,
                        color: textformColor,
                      ),
                      title: Text(
                        "Notifications",
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
                      onTap: () {    },
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
                      onTap: () { },
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
                      onTap: () { },
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
                      onTap: () { },
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
                      onTap: () {  },
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
                    onTap: () { }),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showExitDialog(BuildContext context) {
    Future<bool?> _showExitDialog(BuildContext context) {
      return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }
  }
}
