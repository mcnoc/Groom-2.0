import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class CustomerNotificationPage extends StatefulWidget {
  const CustomerNotificationPage({super.key});

  @override
  State<CustomerNotificationPage> createState() =>
      _CustomerNotificationPageState();
}

class _CustomerNotificationPageState extends State<CustomerNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "New",
              style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/girl.png",
              ),
              radius: 20,
            ),
            title: Text(
              "Reminder! . Get ready for your appointment at 9am",
              style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w500, fontSize: 12),
            ),
            trailing: Column(
              children: [
                Text(
                  "Just Now",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: chatColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: discountTextColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Divider(
              color: tabUnselectedColor.withOpacity(.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Earlier",
              style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.65,
            child: ListView.builder(itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/girl.png",
                      ),
                      radius: 20,
                    ),
                    title: Text(
                      "Reminder! . Get ready for your appointment at 9am",
                      style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          "Just Now",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: chatColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: discountTextColor),
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
            }),
          ),
        ],
      ),
    );
  }
}
