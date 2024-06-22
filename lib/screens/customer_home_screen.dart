import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Groom"),

        automaticallyImplyLeading: false,
        backgroundColor: colorwhite,
        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/ss.png",
                height: 30,
                width: 30,
              ),
            ),
          ),
          TextButton(
              onPressed: () {   },
              child: Text(
                "Chat Page",
                style: TextStyle(color: mainBtnColor),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/banner.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "What do you want to do?",
                style: GoogleFonts.manrope(
                    color: colorBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Popular Providers",
                style: GoogleFonts.manrope(
                    color: colorBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 72,
              width: MediaQuery.of(context).size.width,

            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                "Services",
                style: GoogleFonts.manrope(
                    color: colorBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width,

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    "Nearby Services",
                    style: GoogleFonts.manrope(
                        color: colorBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {   },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8),
                    child: Text(
                      "View All",
                      style: GoogleFonts.manrope(
                          color: mainBtnColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
