import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:groom/states/customer_offer_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../data_models/customer_offer_model.dart';
import '../../firebase/customer_offer_firebase.dart';
import '../google_maps_screen.dart';

class CustomerCreateOfferScreen extends StatefulWidget {
  const CustomerCreateOfferScreen({super.key});

  @override
  State<CustomerCreateOfferScreen> createState() =>
      _CustomerCreateOfferScreenState();
}

List<String> services = ["Hair Style", "Nails", "Facial","coloring","spa","Waxing", "Makeup","Massage"];
List<String> priceRange = ["100-500", "500-1000", "1000-2000"];

class _CustomerCreateOfferScreenState extends State<CustomerCreateOfferScreen> {
  CustomerOfferStateController customerOfferState =
      CustomerOfferStateController();
  LatLng? selectedLocation;
  Uint8List? mapScreenshot;
  String? selectedService;
  String? selectedPriceRange;
  DateTime? selectedDateTime;
  List<File> _images = [];
  bool _isLoading = false;
  bool _depositAccept =false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _images.add(File(pickedImage.path));
      });
    }
  }

  static String generateProjectId() {
    final random = Random();

    final currentDateTime = DateTime.now();
    final formattedDate =
        "${currentDateTime.year}${currentDateTime.month.toString().padLeft(2, '0')}${currentDateTime.day.toString().padLeft(2, '0')}";
    final formattedTime =
        "${currentDateTime.hour.toString().padLeft(2, '0')}${currentDateTime.minute.toString().padLeft(2, '0')}${currentDateTime.second.toString().padLeft(2, '0')}";

    final randomNumbers =
        List.generate(10, (index) => random.nextInt(10)).join();

    final projectId = '$formattedDate$formattedTime$randomNumbers';
    return projectId;
  }

  Future<void> _saveCustomerServiceModel() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      List<String> imageUrls = [];
      for (File image in _images) {
        String imageUrl = await CustomerOfferFirebase()
            .uploadImage(image, FirebaseAuth.instance.currentUser!.uid);
        if (imageUrl.isNotEmpty) {
          imageUrls.add(imageUrl);
        }
      }

      final customerService = CustomerOfferModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        offerId: generateProjectId(),
        description: _descriptionController.text,
        serviceType: selectedService,
        priceRange: selectedPriceRange,
        dateTime: selectedDateTime,
        deposit: _depositAccept,
        location: selectedLocation,
        offerImages: imageUrls,
      );

      await CustomerOfferFirebase()
          .writeOfferToFirebase(customerService.offerId, customerService);
      setState(() {
        _isLoading = false;
      });
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service offer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select date & time :",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue.shade200),
                        borderRadius: BorderRadius.circular(9)),
                    width: 350,
                    height: 120,
                    child: Center(
                      child: SfCalendar(
                        onSelectionChanged: (CalendarSelectionDetails details) {
                          setState(() {
                            selectedDateTime = details.date;
                          });
                        },
                        scheduleViewSettings: ScheduleViewSettings(
                          monthHeaderSettings: MonthHeaderSettings(),
                          dayHeaderSettings: DayHeaderSettings(),
                        ),
                        showNavigationArrow: true,
                        view: CalendarView.timelineDay,
                        viewHeaderStyle: ViewHeaderStyle(
                          dayTextStyle: TextStyle(fontSize: 16),
                        ),
                        timeSlotViewSettings:
                            TimeSlotViewSettings(dayFormat: "E"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // EasyDateTimeLine(
                //   initialDate: DateTime.now(),
                //   onDateChange: (selectedDate) {
                //     //`selectedDate` the new date selected.
                //     setState(() {
                //       selectedDate = selectedDateTime!;
                //       print(selectedDateTime!);
                //     });
                //   },
                //   headerProps: const EasyHeaderProps(
                //     monthPickerType: MonthPickerType.switcher,
                //     dateFormatter: DateFormatter.fullDateDMY(),
                //   ),
                //   dayProps: const EasyDayProps(
                //     dayStructure: DayStructure.dayStrDayNum,
                //     activeDayStyle: DayStyle(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(8)),
                //         gradient: LinearGradient(
                //           begin: Alignment.topCenter,
                //           end: Alignment.bottomCenter,
                //           colors: [
                //             Color(0xff3371FF),
                //             Color(0xff8426D6),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Service Type :",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedService,
                    hint: Text("Select Service"),
                    isExpanded: true,
                    items: services.map((String service) {
                      return DropdownMenuItem<String>(
                        value: service,
                        child: Text(service),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedService = newValue;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a service' : null,
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Price Range :",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedPriceRange,
                    hint: Text("Select Price Range"),
                    isExpanded: true,
                    items: priceRange.map((String range) {
                      return DropdownMenuItem<String>(
                        value: range,
                        child: Text(range),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPriceRange = newValue;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a price range' : null,
                  ),
                ),
                SizedBox(height: 12),
                Row(children: [Checkbox(value: _depositAccept, onChanged: (newBool){
                  setState(() {
                    _depositAccept = newBool!;
                  });
                } ), Text("Accept deposit")],),
                SizedBox(height: 12),
                Text(
                  "Offer description :",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200)),
                    child: TextFormField(
                      controller: _descriptionController,
                      expands: true,
                      maxLines: null,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a description'
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select your location",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (mapScreenshot != null)
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Image.memory(mapScreenshot!),
                      ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(
                        child: TextButton(
                          onPressed: () async {
                            final result =
                                await Get.to(() => GoogleMapScreen());
                            if (result != null) {
                              setState(() {
                                selectedLocation = result['location'];
                                mapScreenshot = result['screenshot'];
                              });
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.locationDot,
                                size: 40,
                                color: Colors.blue.shade200,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add images",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        color: Colors.transparent,
                        child: Image.asset("assets/addImage.png"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.blue.shade200),
                      ),
                         onPressed: _isLoading ? null : _saveCustomerServiceModel,


                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.3,
                        height: 40,
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  "Save",
                                  style: TextStyle(fontSize: 19),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
