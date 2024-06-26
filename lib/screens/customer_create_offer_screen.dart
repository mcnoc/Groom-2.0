import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:groom/states/customer_offer_state.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../data_models/customer_offer_model.dart';
import 'google_maps_screen.dart';

class CustomerCreateOfferScreen extends StatefulWidget {
  const CustomerCreateOfferScreen({super.key});

  @override
  State<CustomerCreateOfferScreen> createState() => _CustomerCreateOfferScreenState();
}

List<String> services = ["Hair Style", "Nails", "Waxing", "Makeup"];
List<String> priceRange = ["100-500", "500-1000", "1000-2000"];

class _CustomerCreateOfferScreenState extends State<CustomerCreateOfferScreen> {


  CustomerOfferStateController customerOfferState = CustomerOfferStateController();
  LatLng? selectedLocation;
  Uint8List? mapScreenshot;


  static String generateProjectId() {
    final random = Random();

    final currentDateTime = DateTime.now();
    final formattedDate =
        "${currentDateTime.year}${currentDateTime.month.toString().padLeft(2, '0')}${currentDateTime.day.toString().padLeft(2, '0')}";
    final formattedTime =
        "${currentDateTime.hour.toString().padLeft(2, '0')}${currentDateTime.minute.toString().padLeft(2, '0')}${currentDateTime.second.toString().padLeft(2, '0')}";

    final randomNumbers =
    List.generate(10, (index) => random.nextInt(10)).join();

    final ProjectId = '$formattedDate$formattedTime$randomNumbers';
    return ProjectId;
  }
  String? selectedService;
  String? selectedPriceRange;
  DateTime? selectedDateTime;

  void saveCustomerServiceModel() {
    final customerService = CustomerOfferModel(
      offerId: "",
      description: "",
      serviceType: selectedService,
      priceRange: selectedPriceRange,
      dateTime: selectedDateTime,
      location: LatLng(0,0)
    );

    final jsonData = customerService.toJson();
    print(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a service offer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Please select date and time :"),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade200),borderRadius: BorderRadius.circular(9)
                  ),
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
                      timeSlotViewSettings: TimeSlotViewSettings(dayFormat: "E"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Service Type"),
              DropdownButton<String>(
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
              ),
              SizedBox(height: 20),
              Text("Price Range"),
              DropdownButton<String>(
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
              ),
              SizedBox(height: 20),
              Text("Offer description"),
              SizedBox(height: 20),
              SizedBox(child: TextField()),
              SizedBox(height: 20),

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
              ElevatedButton(
                onPressed: saveCustomerServiceModel,
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

