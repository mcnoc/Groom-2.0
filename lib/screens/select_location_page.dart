import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../states/provider_state.dart';

class SelectLocationPage extends StatefulWidget {
  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  late GoogleMapController _controller;
  Marker? _selectedMarker;
  final ScreenshotController screenshotController = ScreenshotController();
  Uint8List? mapScreenshot;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _onTap(LatLng position) {
    setState(() {
      _selectedMarker = Marker(
        markerId: MarkerId('selected_location'),
        position: position,
      );
    });
  }

  Future<void> _captureAndSetLocation() async {
    final image = await screenshotController.capture();

    if (image != null) {
      // Save the image to file
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/location_screenshot.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(image);

      // Reverse geocode the location to get the address line
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _selectedMarker!.position.latitude,
        _selectedMarker!.position.longitude,
      );

      String addressLine = placemarks.first.street ?? '';


      // Navigate back
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _selectedMarker == null ? null : _captureAndSetLocation,
          ),
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          onTap: _onTap,
          markers: _selectedMarker != null ? {_selectedMarker!} : {},
          initialCameraPosition: CameraPosition(
            target: LatLng(37.7749, -122.4194),
            zoom: 10,
          ),
        ),
      ),
    );
  }
}
