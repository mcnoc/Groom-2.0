import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groom/screens/customer_main_dashboard.dart';

import '../../consts/pages.dart';
import '../../utils/colors.dart';

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
                  Get.offAll(CustomerMainDashboard());
                },
                child: Text("Customer"))
          ],
        ),
        actions: [
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        backgroundColor: mainBtnColor,
        onPressed: () {},
        child: Icon(Icons.add, color: colorwhite),
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
