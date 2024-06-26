import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import 'add_complaint_screen.dart';
class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: mainBtnColor,
          child: Icon(
            Icons.add,
            color: colorwhite,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => AddComplaint()));
          }),
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorwhite),
        title: Text(
          "Support",
          style: GoogleFonts.workSans(
              color: colorwhite, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: mainBtnColor,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("complains")
                .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                    "No Complains Registered",
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

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title:  " + data['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              data['description'],
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: data['isSolved'] == true
                                      ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                      : Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      onPressed: () async {
                                        // Show the confirmation dialog
                                        bool? confirmDelete = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Confirm Delete"),
                                              content: Text(
                                                  "Are you sure you want to delete this item?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(
                                                        false); // Return false when cancel is pressed
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("Delete"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(
                                                        true); // Return true when delete is pressed
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        // If confirmDelete is true, proceed with deletion
                                        if (confirmDelete == true) {
                                          await FirebaseFirestore.instance
                                              .collection("complains")
                                              .doc(data['uuid'])
                                              .delete();
                                        }
                                      },
                                      child: Text("Delete"),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}