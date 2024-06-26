import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:groom/data_models/provider_user_model.dart';
import 'package:groom/firebase/provider_user_firebase.dart';
import 'package:groom/screens/customer_main_dashboard.dart';
import 'package:image_picker/image_picker.dart';

import '../../states/provider_state.dart';
import '../../widgets/provider_form_widgets/provider_type_widget.dart';
import '../../widgets/provider_form_widgets/services_list_widget.dart';
import '../google_maps_screen.dart';

class ProviderFormPage extends StatefulWidget {
  @override
  State<ProviderFormPage> createState() => _ProviderFormPageState();
}

class _ProviderFormPageState extends State<ProviderFormPage> {
  final FormController formController = Get.put(FormController());
  ProviderUserFirebase providerUserFirebase = ProviderUserFirebase();
  LatLng? selectedLocation;
  Uint8List? mapScreenshot;
  List<File> _images = [];
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _images.add(File(pickedImage.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Groomer Form')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              return Form(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(child: GroomerTypeChoice()),
                      SizedBox(height: 10),
                      Text("Groomer Description :"),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            maxLength: 350,
                            onChanged: (value) {
                              formController.providerUser.update((user) {
                                user?.about = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Address Line"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            autocorrect: true,
                            expands: true,
                            maxLines: null,
                            maxLength: 50,
                            onChanged: (value) {
                              formController.providerUser.update((user) {
                                user?.addressLine = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Work Day From :'),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
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
                      SizedBox(height: 10),
                      Text('Work Day To :'),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
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
                      SizedBox(height: 15),
                      CardListSwap(),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Select your location"),
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
                                      formController.providerUser.value.location =
                                          selectedLocation;
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
                      SizedBox(height: 16),
                      Row(
                        children: [
                          for (var image in _images)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (formController.validateForm()) {
                            setState(() {
                              _isLoading = true;
                            });
                            List<String> imageUrls = [];
                            for (var image in _images) {
                              String url = await providerUserFirebase.uploadImage(
                                  image, FirebaseAuth.instance.currentUser!.uid);
                              if (url.isNotEmpty) {
                                imageUrls.add(url);
                              }
                            }
                            ProviderUserModel providerModel = ProviderUserModel(
                                providerType: formController.selectedGroomerType.toString(),
                                about: formController.providerUser.value.about,
                                workDayFrom: formController.providerUser.value.workDayFrom,
                                providerServices: formController.providerUser.value.providerServices,
                                salonTitle: formController.salonDescription.toString(),
                                providerImages: imageUrls,
                                workDayTo: formController.providerUser.value.workDayTo,
                                location: selectedLocation,
                                addressLine: formController.providerUser.value.addressLine,
                                createdOn: DateTime.now().millisecondsSinceEpoch);
                            await providerUserFirebase.addProvider(
                                FirebaseAuth.instance.currentUser!.uid, providerModel);
                            setState(() {
                              _isLoading = false;
                            });
                            Get.off(() => CustomerMainDashboard());

                            // Submit the form
                          } else {
                            // Show validation error
                            Get.snackbar('Error', 'Please fill all the fields correctly.');
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
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
