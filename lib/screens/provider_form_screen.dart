import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:groom/data_models/provider_user_model.dart';
import 'package:groom/firebase/provider_user_firebase.dart';
import 'package:groom/screens/provider_main_dashboard.dart';

import '../states/provider_state.dart';
import 'google_maps_screen.dart';

class ProviderFormPage extends StatefulWidget {
  @override
  State<ProviderFormPage> createState() => _ProviderFormPageState();
}

class _ProviderFormPageState extends State<ProviderFormPage> {
  final FormController formController = Get.put(FormController());

  ProviderUserFirebase providerUserFirebase = ProviderUserFirebase();
  LatLng? selectedLocation;
  Uint8List? mapScreenshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Provider Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Form(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    maxLength: 350,
                    decoration: InputDecoration(labelText: 'About'),
                    onChanged: (value) {
                      formController.providerUser.update((user) {
                        user?.about = value;
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Work Day From'),
                    items: formController.daysOfWeek.map((String day) {
                      return DropdownMenuItem<String>(
                        value: day,
                        child: Text(day),
                      );
                    }).toList(),
                    onChanged: (value) {
                      formController.providerUser.update((user) {
                        user?.workDayFrom = value ?? '';
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Work Day To'),
                    items: formController.daysOfWeek.map((String day) {
                      return DropdownMenuItem<String>(
                        value: day,
                        child: Text(day),
                      );
                    }).toList(),
                    onChanged: (value) {
                      formController.providerUser.update((user) {
                        user?.workDayTo = value ?? '';
                      });
                    },
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Center Location"),
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Center(
                          child: TextButton(
                            onPressed: () async {
                              final result = await Get.to(() => GoogleMapScreen());
                              if (result != null) {
                                setState(() {
                                  selectedLocation = result['location'];
                                  mapScreenshot = result['screenshot'];
                                  formController.providerUser.value.location = selectedLocation;
                                });
                              }
                            },
                            child: Text("Location"),
                          ),
                        ),
                      ),
                      if (mapScreenshot != null)
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Image.memory(mapScreenshot!),
                        ),

                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Provider Images'),
                  Wrap(
                    children: formController.selectedImages.map((path) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(File(path), width: 100, height: 100),
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    onPressed: formController.pickImages,
                    child: Text('Pick Images'),
                  ),
                  SizedBox(height: 16),

                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (formController.validateForm()) {
                        ProviderUserModel providerModel = ProviderUserModel(
                            about: formController.providerUser.value.about,
                            workDayFrom:
                                formController.providerUser.value.workDayFrom,
                            workDayTo:
                                formController.providerUser.value.workDayTo,
                            location:
                                selectedLocation,
                            addressLine:   formController.providerUser.value.addressLine,
                            createdOn: DateTime.now().millisecondsSinceEpoch);
                        await providerUserFirebase.addProvider(
                            FirebaseAuth.instance.currentUser!.uid,
                            providerModel);
                        Get.off(()=>ProviderMainDashboard());


                        // Submit the form
                      } else {
                        // Show validation error
                        Get.snackbar(
                            'Error', 'Please fill all the fields correctly.');
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
