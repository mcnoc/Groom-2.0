import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/screens/provider_screens/provider_booking_screen.dart';
import 'package:groom/screens/provider_screens/provider_financial_dashboard_screen.dart';
import 'package:groom/screens/provider_screens/provider_review_screen.dart';
import 'package:groom/screens/provider_screens/provider_services_list.dart';

import '../../utils/colors.dart';
import '../../widgets/card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: GoogleFonts.workSans(
                color: colorwhite, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: mainBtnColor,
          actions: [
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FutureBuilder(
                        future: bookingCount(),
                        builder: (context, snapshot) {
                          // Check if the snapshot has data or is still loading
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // While waiting, return a CardWidget with the title set to '0'
                            return CardWidget(
                              title: '0', // Set default value to '0'
                              subTitle: "Booking",
                              icon: "assets/book.png",
                            );
                          } else {
                            // Once the future completes, display the actual data
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => BookingScreen()));
                              },
                              child: CardWidget(
                                title: snapshot.data.toString(),
                                subTitle: "Booking",
                                icon: "assets/book.png",
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10), // Adding space between ListTiles
                    FutureBuilder(
                      future: servicesCount(),
                      builder: (context, snapshot) {
                        // Check if the snapshot has data or is still loading
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While waiting, return a CardWidget with the title set to '0'
                          return CardWidget(
                            title: '0', // Set default value to '0'
                            subTitle: "Services",
                            icon: "assets/services.png",
                          );
                        } else {
                          // Once the future completes, display the actual data
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          ServiceProviderList()));
                            },
                            child: CardWidget(
                              title: snapshot.data.toString(),
                              subTitle: "Services",
                              icon: "assets/services.png",
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => ProviderReviewScreen()));
                          },
                          child: CardWidget(
                            title: "38",
                            subTitle: "Total Reviews",
                            icon: "assets/book.png",
                          ),
                        )),
                    SizedBox(width: 10), // Adding space between ListTiles
                    Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        ProviderFinancialDashboard()));
                          },
                          child: CardWidget(
                            title: "\$55.5",
                            subTitle: "Total Earnings",
                            icon: "assets/services.png",
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Monthly Revenue USD",
                  style: GoogleFonts.workSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: titleColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/chart.png",
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/groom.png",
                          height: 40,
                          width: 40,
                        ),
                        Text(
                          "Groom Services",
                          style: GoogleFonts.workSans(
                              color: titleColor, fontSize: 18),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ServiceProviderList()));
                      },
                      child: Text(
                        "View All",
                        style: GoogleFonts.workSans(
                            color: textformColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("services")
                        .where("uid",
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            "No Service Available",
                            style: TextStyle(color: colorBlack),
                          ),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final List<DocumentSnapshot> documents =
                                snapshot.data!.docs;
                            final Map<String, dynamic> data =
                            documents[index].data() as Map<String, dynamic>;
                            return Card();
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Functions
  servicesCount() async {
    AggregateQuerySnapshot query = await FirebaseFirestore.instance
        .collection('services')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .count()
        .get();

    int? numberOfDocuments = query.count;
    return numberOfDocuments;
  }

  //Booking Count
  bookingCount() async {
    AggregateQuerySnapshot query = await FirebaseFirestore.instance
        .collection('booking')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("bookingStatus", isEqualTo: "start")
        .count()
        .get();

    int? numberOfDocuments = query.count;
    return numberOfDocuments;
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