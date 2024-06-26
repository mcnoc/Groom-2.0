import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groom/screens/provider_screens/provider_main_dashboard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/image_util.dart';
import '../../widgets/signup_screen_widgets/button.dart';
import '../../widgets/signup_screen_widgets/textforminputfield.dart';

class AddServices extends StatefulWidget {
  const AddServices({super.key});

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? selectedLocation; // New variable to hold the selected description
  void setSelectedDescription(String description) {
    setState(() {
      selectedLocation = description;
      locationController.text =
          description; // Optionally set the text field value
    });
  }

  String dropdownvalue = 'Makeup';

  // List of items in our dropdown menu
  var items = [
    'Makeup',
    'Hair Styling',
    'Massage',
    'Skin Care',
    'Wellness & Day Spa',
  ];

  // Image
  Uint8List? _image;

  // Loading bar
  bool isAdded = false;

  // Error message for discount
  String? discountErrorMessage;

  @override
  void initState() {
    super.initState();
    discountController.addListener(_validateDiscount);
  }

  @override
  void dispose() {
    discountController.removeListener(_validateDiscount);
    super.dispose();
  }

  void _validateDiscount() {
    final input = discountController.text;
    if (input.isNotEmpty) {
      final value = int.tryParse(input);
      setState(() {
        discountErrorMessage = (value != null && value > 100)
            ? 'Discount cannot be more than 100%'
            : null;
      });
    } else {
      setState(() {
        discountErrorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: colorwhite,
          ),
        ),
        title: Text(
          "Add Service",
          style: GoogleFonts.workSans(
            color: colorwhite,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: mainBtnColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = (snapshot.data as QuerySnapshot?)?.docs ??
              <QueryDocumentSnapshot>[];

          if (documents.isEmpty) {
            return const Center(
              child: Text(
                "No Friend Found yet",
                style: TextStyle(color: Colors.black),
              ),
            );
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final docs = (snapshot.data as QuerySnapshot?)?.docs ??
                  <QueryDocumentSnapshot>[];
              final datas = docs.isNotEmpty
                  ? docs[index].data() as Map<String, dynamic>?
                  : null;
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => selectImage(),
                    child: _image != null
                        ? CircleAvatar(
                        radius: 59, backgroundImage: MemoryImage(_image!))
                        : GestureDetector(
                      onTap: () => selectImage(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/Choose Image.png"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: TextFormInputField(
                      maxLenght: 15,
                      controller: serviceNameController,
                      hintText: "Service Name",
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF6F7F9),
                    ),
                    margin: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 4, bottom: 5),
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
                    child: DropdownButton(
                      isExpanded: true,
                      value: dropdownvalue,
                      underline: SizedBox(),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: textformColor,
                      ),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: GoogleFonts.nunitoSans(fontSize: 16),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 8),
                          child: TextFormInputField(
                            controller: priceController,
                            hintText: "Price",
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormInputField(
                                controller: discountController,
                                hintText: "Discount",
                                textInputType: TextInputType.number,
                              ),
                              if (discountErrorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Text(
                                    discountErrorMessage!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLength: 30,
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.all(8),
                        fillColor: Color(0xffF6F7F9),
                        hintText: "Description",
                        hintStyle: GoogleFonts.nunitoSans(fontSize: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  isAdded
                      ? Center(
                    child: CircularProgressIndicator(
                      color: mainBtnColor,
                    ),
                  )
                      : SaveButton(
                    title: "Save",
                    onTap: () async {
                      if (_image == null) {
                        showMessageBar("Image is Required", context);
                      } else if (serviceNameController.text.isEmpty) {
                        showMessageBar(
                            "Service Name is Required", context);
                      } else if (locationController.text.isEmpty) {
                        showMessageBar("Location is Required", context);
                      } else if (priceController.text.isEmpty) {
                        showMessageBar("Price is Required", context);
                      } else if (descriptionController.text.isEmpty) {
                        showMessageBar(
                            "Description is Required", context);
                      } else {
                        int discount = 0;
                        if (discountController.text.isNotEmpty) {
                          discount =
                              int.tryParse(discountController.text) ?? 0;
                          if (discount > 100) {
                            showMessageBar(
                                "Discount cannot be more than 100%",
                                context);
                            return;
                          }
                        }

                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // Functions
  /// Select Image From Gallery
  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  void showMessageBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}