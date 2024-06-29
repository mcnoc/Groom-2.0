import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:groom/screens/customer_screens/customer_main_dashboard.dart';
import 'package:groom/screens/provider_screens/provider_create_service_screen.dart';

import '../../consts/pages.dart';
import '../../utils/colors.dart';
import '../customer_screens/customer_create_offer_screen.dart';

class ProviderMainDashboard extends StatefulWidget {
  const ProviderMainDashboard({super.key});

  @override
  State<ProviderMainDashboard> createState() => _ProviderMainDashboardState();
}

class _ProviderMainDashboardState extends State<ProviderMainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = homeScreenSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(width: 40, height: 40, "assets/Groomlogof.png"),
            TextButton(
                onPressed: () {
                  Get.offAll(()=>CustomerMainDashboard());
                },
                child: Text("Customer"))
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                    () => ProviderCreateServiceScreen(),
              );
            },
            icon: FaIcon(FontAwesomeIcons.plus),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.chat),
              ),
              Positioned(
                  right: 6,
                  top: 10,
                  child:
                      Icon(color: Colors.green, size: 15, Icons.closed_caption))
            ],
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications),
              ),
              Positioned(
                  right: 6,
                  top: 10,
                  child:
                      Icon(color: Colors.green, size: 15, Icons.closed_caption))
            ],
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Image.asset(
                    "assets/homeblue.png",
                    height: 25,
                  )
                : Image.asset(
                    "assets/g.png",
                    height: 25,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Image.asset(
                    "assets/bookingblue.png",
                    height: 25,
                  )
                : Image.asset(
                    "assets/bookingno.png",
                    height: 25,
                  ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: _currentIndex == 2
                ? Image.asset(
                    "assets/profileblue.png",
                    height: 25,
                  )
                : Image.asset(
                    "assets/profileno.png",
                    height: 25,
                  ),
          ),
        ],
        selectedItemColor: mainBtnColor,
        unselectedItemColor: textformColor,
        backgroundColor: colorwhite, // Set your desired background color here
      ),
    );
  }
}
