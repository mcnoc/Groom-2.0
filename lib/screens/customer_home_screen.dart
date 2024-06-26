import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/firebase/provider_user_firebase.dart';
import '../data_models/user_model.dart';
import '../utils/colors.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  ProviderUserFirebase providerUserFirebase = ProviderUserFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/banner.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "What do you want to do?",
                style: GoogleFonts.manrope(
                    color: colorBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                          radius: MediaQuery.sizeOf(context).width*0.08,
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
                          radius: MediaQuery.sizeOf(context).width*0.08,
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
                          radius: MediaQuery.sizeOf(context).width*0.08,
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
                          radius: MediaQuery.sizeOf(context).width*0.08,
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
                          radius: MediaQuery.sizeOf(context).width*0.08,
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
                          radius: MediaQuery.sizeOf(context).width*0.08,
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
                          radius: MediaQuery.sizeOf(context).width*0.08,
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
                          radius: MediaQuery.sizeOf(context).width*0.08,
                        ),
                        Text(
                          "Message",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Featured Providers",
                style: GoogleFonts.manrope(
                    color: colorBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: providerUserFirebase.getAllProviders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    var providers = snapshot.data as List<UserModel>;
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: providers.length,
                        itemBuilder: (context, index) {
                          var provider = providers[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.lightGreenAccent,
                                  radius: 32,
                                  child: ClipOval(
                                    clipBehavior: Clip.hardEdge,
                                    child: CachedNetworkImage(
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.fill,
                                      imageUrl: provider.photoURL,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else
                    return Text("no data found");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                "Services",
                style: GoogleFonts.manrope(
                    color: colorBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    "Nearby Services",
                    style: GoogleFonts.manrope(
                        color: colorBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8),
                    child: Text(
                      "View All",
                      style: GoogleFonts.manrope(
                          color: mainBtnColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
