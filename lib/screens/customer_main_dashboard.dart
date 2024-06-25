import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groom/data_models/user_model.dart';
import 'package:groom/firebase/user_firebase.dart';
import 'package:groom/screens/create_booking_screen.dart';
import 'package:groom/states/user_state.dart';

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
  UserStateController userStateController = Get.put(UserStateController());
  UserFirebase userFirebase = UserFirebase();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CustomerHomeScreen(),
    CustomerBookingScreen(),
    CustomerChatScreen(),
    CustomerProfileScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(width: 40, height: 40, "assets/Groomlogof.png"),
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
        onPressed: () {
          Get.to(() => CreateBookingScreen());
        },
        child: Icon(
          Icons.add,
          color: colorwhite,
        ),
      ),
      body: FutureBuilder(
          future: userFirebase.getUser(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              return _screens[_currentIndex];
            }
            return Text("No connection");
          }),
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
