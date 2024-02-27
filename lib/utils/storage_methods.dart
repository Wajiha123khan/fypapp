import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref = _storage
        .ref()
        .child(childName + "/")
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // Future<String> uploadImageOrPdfToStorage(
  //     String childName, file, bool isPost, filetype) async {
  //   // creating location to our firebase storage
  //   String id1 = const Uuid().v4();
  //   Reference ref = _storage.ref().child(childName).child(id1);
  //   if (isPost) {
  //     String id = const Uuid().v1();
  //     ref = ref.child(id);
  //   }

  //   // putting in uint8list format -> Upload task like a future but not future
  //   UploadTask uploadTask = filetype ? ref.putFile(file) : ref.putData(file);

  //   TaskSnapshot snapshot = await uploadTask;
  //   String downloadUrl = await snapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  // Future<String> uploadImageOrPdfToStorage(
  //     String childName, file, bool isPost, filetype) async {
  //   // creating location to our firebase storage
  // String id1 = const Uuid().v4();
  // Reference ref = _storage.ref().child(childName).child(id1);
  //   if (isPost) {
  //     String id = const Uuid().v1();
  //     ref = ref.child(id);
  //   }

  //   // putting in uint8list format -> Upload task like a future but not future
  //   UploadTask uploadTask = filetype ? ref.putFile(file) : ref.putData(file);

  //   TaskSnapshot snapshot = await uploadTask;
  //   String downloadUrl = await snapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  Future<String> uploadPdfToStorage(
    String childName,
    File file,
  ) async {
    String id1 = const Uuid().v4();
    Reference ref = _storage.ref().child(childName).child(id1);

    UploadTask uploadTask = ref.putFile(
        file,
        SettableMetadata(
            contentType: 'image/jpeg',
            customMetadata: {'picked-file-path': file.path}));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> pdfUploadFirestoreTest(
    String childName,
    Uint8List file,
  ) async {
    String id1 = const Uuid().v4();
    Reference ref = _storage.ref().child(childName).child(id1);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
