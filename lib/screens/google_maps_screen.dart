import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import '../states/map_controller.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  static const LatLng _pGooglePlex = LatLng(30.0444, 31.2357);
  MapController mapController = Get.put(MapController());
  final GlobalKey _globalKey = GlobalKey();

  Future<Uint8List?> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          RepaintBoundary(
            key: _globalKey,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Obx(() => GoogleMap(
                initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 13),
                markers: mapController.marker.value != null ? {mapController.marker.value!} : {},
                onTap: (position) {
                  mapController.addMarkerAtPosition(position);
                },
              )),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final location = mapController.marker.value?.position;
              if (location != null) {
                final screenshot = await _capturePng();
                Get.back(result: {'location': location, 'screenshot': screenshot});
              } else {
                Get.snackbar('Error', 'Please select a location first');
              }
            },
            child: Text("Save Location"),
          )
        ],
      ),
    );
  }
}