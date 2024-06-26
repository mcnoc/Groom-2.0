import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';

class OffersAppointment extends StatefulWidget {
  const OffersAppointment({super.key});

  @override
  State<OffersAppointment> createState() => _OffersAppointmentState();
}

class _OffersAppointmentState extends State<OffersAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              var snap = snapshot.data;

              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("postRequest")
                      .where("uid",
                      isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                          "No Service Request Found",
                          style: TextStyle(color: colorBlack),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount:
                        snapshot.data!.docs.length, // Fix the itemCount
                        itemBuilder: (context, index) {
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;
                          final Map<String, dynamic> data =
                          documents[index].data() as Map<String, dynamic>;
                          DateTime date = (data['date'] as Timestamp)
                              .toDate(); // Convert timestamp to DateTime

                          return Column(
                            children: [

                              ElevatedButton(
                                onPressed: () {

                                },
                                child: Text(
                                  "Send Inquiry",
                                  style: GoogleFonts.workSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: colorwhite),
                                ),
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(151, 50),
                                    backgroundColor: mainBtnColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                              )
                            ],
                          );
                        });
                  });
            }));
  }
}