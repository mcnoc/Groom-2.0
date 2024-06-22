import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'customer_booking_screen.dart';
import 'customer_home_screen.dart';
import 'customertab/customer_chat_screen.dart';
import 'customertab/customer_profile_screen.dart';

class CustomerMainDashboard extends StatefulWidget {
  const CustomerMainDashboard({super.key});

  @override
  State<CustomerMainDashboard> createState() => _CustomerMainDashboardState();
}

class _CustomerMainDashboardState extends State<CustomerMainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CustomerHomeScreen(),
    CustomerBookingScreen(),
    CustomerChatScreen(),
    CustomerProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        backgroundColor: mainBtnColor,
        onPressed: () { },
        child: Icon(
          Icons.add,
          color: colorwhite,
        ),
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
              label: "Chat",
              icon: _currentIndex == 2
                  ? Image.asset(
                "assets/chatblue.png",
                height: 25,
              )
                  : Image.asset(
                "assets/chatno.png",
                height: 25,
              )),
          BottomNavigationBarItem(
            label: "Profile",
            icon: _currentIndex == 3
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
