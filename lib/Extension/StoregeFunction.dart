import 'package:firebase_storage/firebase_storage.dart';

enum StorageRef { userImage }

extension StorageRefExtension on StorageRef {
  String get path {
    switch (this) {
      case StorageRef.userImage:
        return "UserImage";
      default:
        return "";
    }
  }
}

Reference storageRef(StorageRef ref) {
  return FirebaseStorage.instance.ref().child(ref.path);
}

Future<String> uploadStorage(StorageRef ref, String path, dynamic file) async {
  Reference filePath = storageRef(ref).child(path);

  await filePath.putFile(file);

  String fileUrl = await filePath.getDownloadURL();

  return fileUrl;
}
