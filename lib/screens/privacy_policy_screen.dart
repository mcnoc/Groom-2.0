import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class CustomerPrivacyPolicy extends StatefulWidget {
  const CustomerPrivacyPolicy({super.key});

  @override
  State<CustomerPrivacyPolicy> createState() => _CustomerPrivacyPolicyState();
}

class _CustomerPrivacyPolicyState extends State<CustomerPrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorwhite,
            )),
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.workSans(
              color: colorwhite, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: mainBtnColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 600,
                  width: 327,
                  child: Text(
                      "Groom respects your privacy.This Privacy Policy explains how Groom collects, uses, and discloses information from and about users '(you' or 'your') of our platform ('Platform'). We are committed to protecting your privacy and ensuring the security of your information. By using the Platform, you agree to the collection, use, and disclosure of information in accordance with this Privacy Policy. We may collect information you provide directly (like account information), information collected automatically (like device data), and information from third parties (like social media logins). We use this information to operate the Platform, provide services, personalize your experience, communicate with you, and improve our offerings. We may share your information with service providers and as required by law. We implement security measures to protect your information, but no website or internet transmission is completely secure. You can access, update, or delete your information through your account settings"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}