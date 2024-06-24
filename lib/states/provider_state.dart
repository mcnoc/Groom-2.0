import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../data_models/provider_user_model.dart';

class FormController extends GetxController {
  var providerUser = ProviderUserModel(
    about: '',
    workDayFrom: '',
    workDayTo: '',
    location: LatLng(0,0),
    addressLine: '',
    createdOn: DateTime.now().millisecondsSinceEpoch,
  ).obs;

  var daysOfWeek = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ].obs;

  var selectedImages = <String>[].obs;

  var isLocationSelected = false.obs;
  var locationScreenshot = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      selectedImages.addAll(images.map((image) => image.path).toList());
      providerUser.update((user) {
        user?.providerImages = selectedImages.toList();
      });
    }
  }

  void setLocation(LatLng location, String addressLine, String screenshot) {
    providerUser.update((user) {
      user?.location = location;
      user?.addressLine = addressLine;
    });
    locationScreenshot.value = screenshot;
    isLocationSelected.value = true;
  }

  bool validateForm() {
    return providerUser.value.about.isNotEmpty &&
        providerUser.value.workDayFrom.isNotEmpty &&
        providerUser.value.workDayTo.isNotEmpty &&
        providerUser.value.about.length <= 350;
  }
}
