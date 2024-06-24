import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data_models/map_model.dart';

class MapController extends GetxController {
  List<MapModel> mapModel = <MapModel>[].obs;
  var markers = <Marker>{}.obs;
  var isLoading = false.obs;
  Rx<Marker?> marker = Rx<Marker?>(null); // Observable for a single marker

  void createMarkers() {
    for (var element in mapModel) {
      markers.add(
        Marker(
          markerId: MarkerId(element.id.toString()),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: LatLng(element.latitude, element.longitude),
          infoWindow: InfoWindow(title: element.name, snippet: element.city),
          onTap: () {
            print("marker tapped");
          },
        ),
      );
    }
  }

  void addMarkerAtPosition(LatLng position) {
    final newMarker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(title: 'New Marker', snippet: 'Custom Location'),
      onTap: () {
        print("marker at $position tapped");
      },
    );

    marker.value = newMarker; // Update the marker
  }
}