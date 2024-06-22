import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';

class CustomerChatPage extends StatefulWidget {
  final bool showAppBar;
  CustomerChatPage({Key? key, this.showAppBar = false});

  @override
  State<CustomerChatPage> createState() => _CustomerChatPageState();
}

class _CustomerChatPageState extends State<CustomerChatPage> {
  late TextEditingController myController;
  Stream<QuerySnapshot>? _stream;

  @override
  void initState() {
    super.initState();
    myController = TextEditingController();
    _stream = FirebaseFirestore.instance
        .collection("chats")
        .where("customerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(color: colorwhite),
              title: Text(
                "Chat",
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorwhite,
                ),
              ),
              backgroundColor: mainBtnColor,
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 68,
                width: 343,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: myController,
                    onChanged: (value) {
                      setState(() {
                        if (value.trim().isEmpty) {
                          _stream = FirebaseFirestore.instance
                              .collection("chats")
                              .where("customerId",
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .snapshots();
                        } else {
                          _stream = FirebaseFirestore.instance
                              .collection("chats")
                              .where("customerId",
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .where("providerName",
                                  isGreaterThanOrEqualTo: value.trim())
                              .where("providerName",
                                  isLessThanOrEqualTo: value.trim() + '\uf8ff')
                              .snapshots();
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.nunitoSans(
                        color: Color(0xffADB3BC),
                        fontSize: 14,
                      ),
                      hintText: "Search messages or salon",
                      prefixIcon: Icon(Icons.search, color: mainBtnColor),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffF0F3F6),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Color(0xffF0F3F6)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Color(0xffF0F3F6)),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Color(0xffF0F3F6)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: StreamBuilder(
                stream: _stream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "No Chat Started Yet",
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
                      DateTime date = (data['chatTime'] as Timestamp).toDate();
                      String formattedTime = DateFormat.jm().format(date);

                      return Column(
                        children: [
                          ListTile(
                            onTap: () { },
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data['providerPhoto']),
                              radius: 20,
                            ),
                            title: Text(
                              data['providerName'],
                              style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("messages")
                                    .doc(groupChatId(data!['customerId']))
                                    .collection(groupChatId(data['customerId']))
                                    .orderBy("timestamp", descending: true)
                                    .limit(1)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data!.docs.isNotEmpty) {
                                    final latestMessage =
                                        snapshot.data!.docs.first.data()
                                            as Map<String, dynamic>;
                                    return Text(
                                      latestMessage['content'],
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: chatColor),
                                    );
                                  } else {
                                    return Text(
                                      "No messages yet",
                                      style: GoogleFonts.abhayaLibre(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  }
                                }),
                            trailing: Column(
                              children: [
                                Text(
                                  formattedTime,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: chatColor),
                                ),
                                Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: discountTextColor),
                                  child: Text(
                                    "2",
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: colorwhite),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Divider(
                              color: tabUnselectedColor.withOpacity(.4),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String groupChatId(String customerId) {
    if (FirebaseAuth.instance.currentUser!.uid.hashCode <=
        customerId.hashCode) {
      return "${FirebaseAuth.instance.currentUser!.uid}-$customerId";
    } else {
      return "$customerId-${FirebaseAuth.instance.currentUser!.uid}";
    }
  }
}
