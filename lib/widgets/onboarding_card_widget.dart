import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groom/main.dart';

import '../consts/intro_page_consts.dart';

class OnboardingCardWidget extends StatelessWidget {
  final String image, text1, text2;
  final Function onPressed;

  const OnboardingCardWidget(
      {super.key,
      required this.image,
      required this.text1,
      required this.text2,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Image.asset(
            image,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          color: Colors.black.withOpacity(0.35), // Semi-transparent overlay
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                text1,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 250,
                child: Text(
                  text2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w200),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.blue.shade200),
                ),
                onPressed: () => onPressed(),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         Get.offAll(AuthenticationWrapper());
              //       },
              //       child: Text(
              //         "Skip",
              //         textAlign: TextAlign.end,
              //         style: TextStyle(fontSize: 14, color: Colors.white),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 20,
              //     )
              //   ],
              // ),
              SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
