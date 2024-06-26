import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/screens/customer_home_screen.dart';
import 'package:groom/screens/customer_main_dashboard.dart';
import 'package:groom/screens/login_screen.dart';
import 'package:groom/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase/messaging_firebase.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance;
  final prefs = await SharedPreferences.getInstance();
  final onBoarding = prefs.getBool("onboarding")??false;

  runApp( MyApp(onboarding: onBoarding,));
}


Future<void> initNotifications() async {
  await FirebaseMessaging.instance.requestPermission();
  final fCMToken = await FirebaseMessaging.instance.getToken();
  print("Token : ${fCMToken}");
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessaging);
}

class MyApp extends StatelessWidget {
  final bool onboarding;

  const MyApp({super.key, this.onboarding =false});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Groom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(

          bodyLarge: GoogleFonts.fahkwang(),
        )

      ),
      home: onboarding ? AuthenticationWrapper() : OnboardingScreen()
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return CustomerMainDashboard();
    }
    return const UserLoginScreen();
  }
}