import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data_models/provider_service_model.dart';
import '../../data_models/user_model.dart';
import '../../firebase/provider_service_firebase.dart';
import '../../firebase/user_firebase.dart';

class NearbyServiceWidget extends StatelessWidget {
  const NearbyServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderServiceFirebase providerServiceFirebase = ProviderServiceFirebase();
    UserFirebase userFirebase = UserFirebase();

    Future<UserModel> fetchUser(String userId) async {
      return await userFirebase.getUser(userId);
    }
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.4,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: providerServiceFirebase.getAllServices(),
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
                  return FutureBuilder<UserModel>(
                    future: fetchUser(service.userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (snapshot.hasData) {
                        var userModelService = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.45,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.18,
                                              child: CachedNetworkImage(
                                                imageUrl: service
                                                    .serviceImages!.first,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            CircleAvatar(
                                              child: Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 7,),
                                        Container(
                                          decoration: BoxDecoration(),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.45,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.12,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                service.serviceType,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                    Colors.blue.shade400),
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
                                                    FontWeight.bold),
                                              )
                                                  : Text(
                                                userModelService!
                                                    .fullName ??
                                                    'Unknown',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Container(
                                                width: 190,
                                                child: Text(
                                                  userModelService
                                                      .providerUserModel!
                                                      .addressLine,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors
                                                        .orangeAccent.shade700,
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
    );
  }
}
