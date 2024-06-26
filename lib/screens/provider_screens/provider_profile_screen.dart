import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/screens/provider_screens/provider_myservice_screen.dart';

import '../../utils/colors.dart';
import '../customer_support_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isGoogleSignIn =>
      _auth.currentUser?.providerData[0].providerId == 'google.com';

  void shareInviteLink(BuildContext context) {
    // Replace 'YOUR_INVITE_LINK' with your actual invite link
    final String inviteLink = 'https://yourapp.com/invite?ref=friend123';

  }

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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => MyService()));
                      },
                      leading: Icon(
                        Icons.dashboard,
                        color: textformColor,
                      ),
                      title: Text(
                        "My Service",
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
                      onTap: () {
                        shareInviteLink(context);
                      },
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
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => CustomerSupport()));
                      },
                      leading: Icon(
                        Icons.support,
                        color: textformColor,
                      ),
                      title: Text(
                        "Support",
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
                      leading: Icon(
                        Icons.workspace_premium,
                        color: textformColor,
                      ),
                      title: Text(
                        "Premium Feature",
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
                    // ListTile(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (builder) => ProviderEditProfile()));
                    //   },
                    //   leading: Icon(
                    //     Icons.edit,
                    //     color: textformColor,
                    //   ),
                    //   title: Text(
                    //     "Edit Profile",
                    //     style: GoogleFonts.workSans(
                    //         fontWeight: FontWeight.w500, fontSize: 16),
                    //   ),
                    //   trailing: Icon(
                    //     Icons.arrow_forward_ios,
                    //     color: textformColor,
                    //   ),
                    // ),
                    //
                    // ListTile(
                    //   onTap: () {
                    //     showDialog<void>(
                    //       context: context,
                    //       barrierDismissible: false, // user must tap button!
                    //       builder: (BuildContext context) {
                    //         return CustomerLogoutWidget();
                    //       },
                    //     );
                    //   },
                    //   leading: Icon(
                    //     Icons.logout,
                    //     color: textformColor,
                    //   ),
                    //   title: Text(
                    //     "Logout",
                    //     style: GoogleFonts.workSans(
                    //         fontWeight: FontWeight.w500, fontSize: 16),
                    //   ),
                    //   trailing: Icon(
                    //     Icons.arrow_forward_ios,
                    //     color: textformColor,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.info,
                        color: textformColor,
                      ),
                      title: Text(
                        "About ",
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