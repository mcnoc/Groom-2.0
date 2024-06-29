import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/firebase/provider_service_firebase.dart';
import 'package:groom/firebase/provider_user_firebase.dart';
import 'package:groom/firebase/user_firebase.dart';
import 'package:groom/states/provider_service_state.dart';
import '../../data_models/user_model.dart';
import '../../utils/colors.dart';
import '../../widgets/home_screen_widgets/all_provider_widget.dart';
import '../../widgets/home_screen_widgets/all_service_widget.dart';
import '../../widgets/home_screen_widgets/nearby_service_widget.dart';
import '../../widgets/home_screen_widgets/serivce_options_widget.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  ProviderUserFirebase providerUserFirebase = ProviderUserFirebase();
  ProviderServiceFirebase providerServiceFirebase = ProviderServiceFirebase();
  ProviderServiceState providerServiceState = Get.put(ProviderServiceState());
  UserFirebase userFirebase = UserFirebase();

  Future<UserModel> fetchUser(String userId) async {
    return await userFirebase.getUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/banner.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.82,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade200),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search...',
                            ),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
            SerivceOptionsWidget(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Featured Providers",
                style: GoogleFonts.manrope(
                    color: colorBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AllProviderWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    "Services for you",
                    style: GoogleFonts.manrope(
                        color: colorBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
            AllServiceWidget(),
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
                  onTap: () {},
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
            NearbyServiceWidget(),

          ],
        ),
      ),
    );
  }
}
