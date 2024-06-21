import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class CustomUtilities {
  static Future<Uint8List?> pickImageFromGallery() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return await image.readAsBytes();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return null;
  }
}
