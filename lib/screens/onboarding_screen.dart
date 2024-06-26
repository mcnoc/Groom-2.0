import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groom/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../consts/intro_page_consts.dart';
import '../widgets/onboarding_card_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static final PageController pageController = PageController(initialPage: 0);
  List<Widget> _onBoardingPages = [
    OnboardingCardWidget(
      image: 'assets/introImage1.png',
      text1: introString1,
      text2: introString2,
      onPressed: () {
        pageController.animateToPage(1,
            duration: Durations.long1, curve: Curves.linear);
      },
    ),
    OnboardingCardWidget(
      image: 'assets/introImage2.png',
      text1: introString3,
      text2: introString4,
      onPressed: () {
        pageController.animateToPage(2,
            duration: Durations.long1, curve: Curves.linear);
      },
    ),
    OnboardingCardWidget(
      image: 'assets/introImage3.png',
      text1: introString5,
      text2: introString6,
      onPressed: () {
        pageController.animateToPage(4,
            duration: Durations.long1, curve: Curves.linear);
      },
    ),
    OnboardingCardWidget(
      image: 'assets/introImage4.png',
      text1: introString7,
      text2: introString7,
      onPressed: () async{
        final pres = await SharedPreferences.getInstance();
        pres.setBool("onboarding", true);
        Get.offAll(
          AuthenticationWrapper(),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SmoothPageIndicator(controller: pageController, count: 3),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: _onBoardingPages,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
