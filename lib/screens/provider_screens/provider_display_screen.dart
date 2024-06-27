import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/states/provider_service_state.dart';

import '../../data_models/provider_service_model.dart';
import '../../firebase/provider_service_firebase.dart';
import '../../utils/colors.dart';

class ProviderDisplayScreen extends StatefulWidget {
  const ProviderDisplayScreen({super.key});

  @override
  State<ProviderDisplayScreen> createState() => _ProviderDisplayScreenState();
}

class _ProviderDisplayScreenState extends State<ProviderDisplayScreen> {
  ProviderServiceState providerServiceState = Get.find();
  ProviderServiceFirebase providerServiceFirebase = ProviderServiceFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [

                CachedNetworkImage(
                  imageUrl: providerServiceState.selectedProvider.value
                      .providerUserModel!.providerImages!.first,
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                "About:",
                style: GoogleFonts.manrope(
                    fontSize: 16, fontWeight: FontWeight.bold, color: titleColor),
              ),
            ),
            SizedBox(
              width: 343,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                "Opening Days:",
                style: GoogleFonts.manrope(
                    fontSize: 16, fontWeight: FontWeight.bold, color: titleColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        providerServiceState.selectedProvider.value
                            .providerUserModel!.workDayFrom,
                        style: GoogleFonts.nunitoSans(
                            color: chatColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        providerServiceState
                            .selectedProvider.value.providerUserModel!.workDayTo,
                        style: GoogleFonts.manrope(
                            color: colorBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
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
                    fontSize: 16, fontWeight: FontWeight.bold, color: titleColor),
              ),
            ),
            SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: providerServiceFirebase.getAllServicesByUserId(
                    providerServiceState.selectedProvider.value.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    var services = snapshot.data as List<ProviderServiceModel>;
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          var service = services[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(),
                                CircleAvatar(
                                  backgroundColor: Colors.blueGrey.shade50,
                                  radius: 32,
                                  child: ClipOval(
                                    clipBehavior: Clip.hardEdge,
                                    child: CachedNetworkImage(
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.fill,
                                      imageUrl: service.serviceImages!.first,
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
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Text(
                "Reviews",
                style: GoogleFonts.manrope(
                    fontSize: 16, fontWeight: FontWeight.bold, color: titleColor),
              ),
            ),
            SizedBox(
              height: 300,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: (){},
                  child: CircleAvatar(
                    radius: 40,
                    child: FaIcon(FontAwesomeIcons.message),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: 60,
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
