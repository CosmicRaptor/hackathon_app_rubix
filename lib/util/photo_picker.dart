import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  if (image == null) return null;

  final fileName = 'images/${DateTime.now()}.png';
  final storageRef = FirebaseStorage.instance.ref().child(fileName);

  try {
    await storageRef.putFile(File(image.path));
    return await storageRef.getDownloadURL();
  } catch (e) {
    print(e);
    return null;
  }
}
