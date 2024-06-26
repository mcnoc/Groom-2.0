import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/screens/provider_screens/provider_booking_offer_tab.dart';
import 'package:groom/screens/provider_screens/provider_booking_previous_tab.dart';
import 'package:groom/screens/provider_screens/provider_booking_upcoming_tab.dart';

import '../../utils/colors.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false;
      },
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Your Bookings"),
            bottom: TabBar(
              indicatorColor: mainBtnColor,
              labelColor: mainBtnColor,
              labelStyle: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: tabUnselectedColor,
              unselectedLabelStyle: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              tabs: <Widget>[
                Tab(
                  text: "Past",
                ),
                Tab(
                  text: "UpComing",
                ),
                Tab(
                  text: "Offers",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              PastAppointment(),
              UpComingAppointment(),
              OffersAppointment()
            ],
          ),
        ),
      ),
    );
  }

  _showExitDialog(BuildContext context) {
    Future<bool?> _showExitDialog(BuildContext context) {
      return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }
  }
}