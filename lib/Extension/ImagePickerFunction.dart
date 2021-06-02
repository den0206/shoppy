import 'dart:io';

import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

Future<File> setGalleryImage() async {
  List<Asset> resultList = <Asset>[];

  resultList = await MultiImagePicker.pickImages(
    maxImages: 1,
    selectedAssets: resultList,
    cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
    materialOptions: MaterialOptions(
      actionBarColor: "#abcdef",
      actionBarTitle: "Example App",
      allViewTitle: "All Photos",
      useDetailsView: false,
      selectCircleStrokeColor: "#000000",
    ),
  );

  var path2 =
      await FlutterAbsolutePath.getAbsolutePath(resultList.first.identifier);

  return File(path2);
}

Future<File> openCamera() async {
  final picker = ImagePicker();
  final pickImage = await picker.getImage(source: ImageSource.camera);
  final pickedImageFile = File(pickImage.path);

  return pickedImageFile;
}
