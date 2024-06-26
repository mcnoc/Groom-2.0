import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';

class UpComingAppointment extends StatefulWidget {
  const UpComingAppointment({super.key});

  @override
  State<UpComingAppointment> createState() => _UpComingAppointmentState();
}

class _UpComingAppointmentState extends State<UpComingAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("booking")
              .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where("bookingStatus", isEqualTo: "start")
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
                  "No Available Booking Start",
                  style: TextStyle(color: colorBlack),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  final Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;

                  Timestamp timestamp = data['date'];
                  DateTime dateTime = timestamp.toDate();
                  String formattedDate =
                  DateFormat('yyyy-MM-dd').format(dateTime);

                  String timeString = data['time'];

                  // Extract the substring between parentheses
                  String timeSubstring = timeString.substring(
                      timeString.indexOf('(') + 1, timeString.indexOf(')'));

                  // Split the substring using the colon as the delimiter
                  List<String> parts = timeSubstring.split(':');

                  // Extract hours and minutes as integers
                  int hours = int.parse(parts[0]);
                  int minutes = int.parse(parts[1]);
                  return null;
                });
          }),
    );
  }
}