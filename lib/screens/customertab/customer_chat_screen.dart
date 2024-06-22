import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import 'customer_chat_page.dart';

class CustomerChatScreen extends StatefulWidget {
  const CustomerChatScreen({super.key});

  @override
  State<CustomerChatScreen> createState() => _CustomerChatScreenState();
}

class _CustomerChatScreenState extends State<CustomerChatScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false;
      },
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TabBar(
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
                  text: "Message",
                ),
                Tab(
                  text: "Notification",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              CustomerChatPage(
                showAppBar: false,
              ),
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
