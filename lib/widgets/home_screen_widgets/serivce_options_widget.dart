import 'package:flutter/material.dart';

class SerivceOptionsWidget extends StatelessWidget {
  const SerivceOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 35.0, vertical: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          spacing: 12,
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade50,
                  child: Image.asset("assets/haircutIcon.png"),
                  radius: MediaQuery.sizeOf(context).width * 0.08,
                ),
                Text(
                  "HairCut",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade50,
                  child: Image.asset("assets/nailsIcon.png"),
                  radius: MediaQuery.sizeOf(context).width * 0.08,
                ),
                Text(
                  "Nails",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade50,
                  child: Image.asset("assets/facialIcon.png"),
                  radius: MediaQuery.sizeOf(context).width * 0.08,
                ),
                Text(
                  "Facial",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade50,
                  child: Image.asset("assets/coloringIcon.png"),
                  radius: MediaQuery.sizeOf(context).width * 0.08,
                ),
                Text(
                  "Coloring",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade50,
                  child: Image.asset("assets/spaIcon.png"),
                  radius: MediaQuery.sizeOf(context).width * 0.08,
                ),
                Text(
                  "Spa",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade50,
                  child: Image.asset("assets/waxingIcon.png"),
                  radius: MediaQuery.sizeOf(context).width * 0.08,
                ),
                Text(
                  "Waxing",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade50,
                  child: Image.asset("assets/makeupIcon.png"),
                  radius: MediaQuery.sizeOf(context).width * 0.08,
                ),
                Text(
                  "Make up",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade50,
                  child: Image.asset("assets/massageIcon.png"),
                  radius: MediaQuery.sizeOf(context).width * 0.08,
                ),
                Text(
                  "Massage",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
