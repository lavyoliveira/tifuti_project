import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SelectImageViewModel extends GetxController {
  File? imageFile;
  String? picUrl;

  cameraImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 400,
      maxWidth: 400,
    );
    imageFile = File(pickedFile!.path);
    update();
  }

  galleryImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 400,
      maxWidth: 400,
    );
    imageFile = File(pickedFile!.path);
    update();
  }

  uploadImageToFirebase() async {
    String fileName = basename(imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profilePics/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);
    picUrl = await (await uploadTask).ref.getDownloadURL();
  }
}
