import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/states/provider_service_state.dart';

import '../../data_models/provider_service_model.dart';
import '../../data_models/user_model.dart';
import '../../firebase/provider_service_firebase.dart';
import '../../firebase/user_firebase.dart';
import '../../utils/colors.dart';
import '../chat_screen.dart';

class ProviderDisplayScreen extends StatefulWidget {
  const ProviderDisplayScreen({super.key});

  @override
  State<ProviderDisplayScreen> createState() => _ProviderDisplayScreenState();
}

class _ProviderDisplayScreenState extends State<ProviderDisplayScreen> {
  ProviderServiceState providerServiceState = Get.find();
  ProviderServiceFirebase providerServiceFirebase = ProviderServiceFirebase();
  UserFirebase userFirebase = UserFirebase();

  final List<String> filters = [
    "All",
    "Hair Style",
    "Nails",
    "Facial",
    "coloring",
    "spa",
    "Waxing",
    "Makeup",
    "Massage"
  ];
  String selectedFilter = "All";

  Future<UserModel> fetchUser(String userId) async {
    return await userFirebase.getUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: providerServiceState
                  .selectedProvider.value.providerUserModel!.providerImages!
                  .map((e) {
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: CachedNetworkImage(
                      imageUrl: e,
                      fit: BoxFit.cover,
                      width: 1000.0,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 300,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                providerServiceState.selectedProvider.value.providerUserModel!
                            .salonTitle !=
                        null
                    ? providerServiceState
                        .selectedProvider.value.fullName.capitalizeFirst!
                    : providerServiceState.selectedProvider.value
                        .providerUserModel!.salonTitle!.capitalizeFirst!,
                style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: titleColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                providerServiceState.selectedProvider.value.providerUserModel!
                    .addressLine.capitalizeFirst!,
                style: GoogleFonts.manrope(fontSize: 16, color: titleColor),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade700,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("4.7"),
                      Text("(2.7 miles)"),
                    ],
                  ),
                  Row(
                    children: [
                      FaIcon(FontAwesomeIcons.eye),
                      SizedBox(
                        width: 10,
                      ),
                      Text("10K views"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(
                height: 8,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                "About:",
                style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: titleColor),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: 343,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  providerServiceState
                      .selectedProvider.value.providerUserModel!.about,
                  style: GoogleFonts.nunitoSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: chatColor),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                "Working Days :",
                style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: titleColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text("From :"),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        providerServiceState.selectedProvider.value
                            .providerUserModel!.workDayFrom!,
                        style: GoogleFonts.nunitoSans(
                            color: chatColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("To :"),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        providerServiceState.selectedProvider.value
                            .providerUserModel!.workDayTo!,
                        style: GoogleFonts.manrope(
                            color: colorBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                "Our Services",
                style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: titleColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 8.0,
                children: filters.map((filter) {
                  return ChoiceChip(
                    label: Text(filter),
                    selected: selectedFilter == filter,
                    onSelected: (selected) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: providerServiceFirebase.getAllServicesByUserId(
                    providerServiceState.selectedProvider!.value.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    var services = snapshot.data as List<ProviderServiceModel>;
                    var filteredServices = selectedFilter == "All"
                        ? services
                        : services
                            .where((service) =>
                                service.serviceType == selectedFilter)
                            .toList();

                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: filteredServices.length,
                        itemBuilder: (context, index) {
                          var service = filteredServices[index];
                          return FutureBuilder<UserModel>(
                            future: fetchUser(service.userId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                var userModelService = snapshot.data;
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.38,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.18,
                                                      child: CachedNetworkImage(
                                                        imageUrl: service
                                                            .serviceImages!
                                                            .first,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    CircleAvatar(
                                                      child: Icon(
                                                        Icons
                                                            .favorite_border_outlined,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        service.serviceType,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .blue.shade400),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      userModelService!
                                                                  .providerUserModel!
                                                                  .providerType !=
                                                              "Independent"
                                                          ? Text(
                                                              userModelService
                                                                  .providerUserModel!
                                                                  .salonTitle!,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text(
                                                              userModelService!
                                                                      .fullName ??
                                                                  'Unknown',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        width: 190,
                                                        child: Text(
                                                          userModelService
                                                              .providerUserModel!
                                                              .addressLine,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors
                                                                .orangeAccent
                                                                .shade700,
                                                          ),
                                                          Text("4.8(3.1 ml)")
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Text("no data found");
                              }
                            },
                          );
                        });
                  } else {
                    return Text("no data found");
                  }
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(),
                onPressed: () {},
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: Text(
                    "View All Services",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                "Gallery",
                style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: titleColor),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => ChatDetailScreen(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          friendId:
                              providerServiceState.selectedProvider.value.uid,
                        ));
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: FaIcon(
                      FontAwesomeIcons.message,
                      color: Colors.blue.shade200,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.blue.shade200)),
                  onPressed: () {},
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: 60,
                    child: Center(
                      child: Text(
                        "Send Service Request",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
