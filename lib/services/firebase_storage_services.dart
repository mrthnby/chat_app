import 'dart:io';


import 'package:firebase_storage/firebase_storage.dart';

import 'base_services/storage_base.dart';

class FirebaseStorageServices implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  late Reference ref;

  @override
  Future<String> upload(String userID, String fileType, File file) async {
    ref = _firebaseStorage.ref().child(userID).child(fileType);
    var upload = ref.putFile(file);
    late String url;
    await upload.whenComplete(() async {
      url = await ref.getDownloadURL();
    });
    return url;
  }
}
