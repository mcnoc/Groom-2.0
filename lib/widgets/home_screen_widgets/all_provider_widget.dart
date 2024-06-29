import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data_models/user_model.dart';
import '../../firebase/provider_service_firebase.dart';
import '../../firebase/provider_user_firebase.dart';
import '../../firebase/user_firebase.dart';
import '../../screens/provider_screens/provider_display_screen.dart';
import '../../states/provider_service_state.dart';

class AllProviderWidget extends StatelessWidget {
  const AllProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderServiceFirebase providerServiceFirebase = ProviderServiceFirebase();
    ProviderUserFirebase providerUserFirebase = ProviderUserFirebase();
    UserFirebase userFirebase = UserFirebase();
    ProviderServiceState providerServiceState = Get.put(ProviderServiceState());

    Future<UserModel> fetchUser(String userId) async {
      return await userFirebase.getUser(userId);
    }
    return  SizedBox(
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
                        GestureDetector(
                          onTap: () {
                            providerServiceState
                                .selectedProvider.value = provider;
                            Get.to(() => ProviderDisplayScreen());
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey.shade50,
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
                        ),
                      ],
                    ),
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
