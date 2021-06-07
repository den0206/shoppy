import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppy/Extension/ImagePickerFunction.dart';
import 'package:shoppy/model/product.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      validator: (image) {
        if (image.isEmpty) {
          return "No Image";
        }
        return null;
      },
      onSaved: (images) => product.newImages = images,
      builder: (state) {
        void onSelectedImage(File file) {
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).primaryColor,
                autoplay: false,
                images: state.value.map<Widget>((image) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      if (image is String)
                        Image.network(
                          image,
                          fit: BoxFit.cover,
                        )
                      else
                        Image.file(
                          image as File,
                          fit: BoxFit.cover,
                        ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.remove),
                          color: Colors.red,
                          onPressed: () {
                            state.value.remove(image);
                            state.didChange(state.value);
                          },
                        ),
                      )
                    ],
                  );
                }).toList()
                  ..add(
                    Material(
                      color: Colors.grey[100],
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        color: Theme.of(context).primaryColor,
                        iconSize: 50,
                        onPressed: () {
                          if (Platform.isAndroid)
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => ImageSourceSheet(
                                onSelectedImage: onSelectedImage,
                              ),
                            );
                          else
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => ImageSourceSheet(
                                onSelectedImage: onSelectedImage,
                              ),
                            );
                        },
                      ),
                    ),
                  ),
              ),
            ),
            if (state.hasError)
              Container(
                margin: EdgeInsets.only(top: 16, left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({
    Key key,
    @required this.onSelectedImage,
  }) : super(key: key);

  final ImagePicker picker = ImagePicker();
  final Function(File) onSelectedImage;

  @override
  Widget build(BuildContext context) {
    /// Crop(Edit)Image
    ///
    Future<void> cropImage(String path) async {
      final File croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: "Edit Image",
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
        ),
        iosUiSettings: IOSUiSettings(
          title: "Edit Image",
          cancelButtonTitle: "Cancel",
          doneButtonTitle: "Continue",
        ),
      );

      if (croppedFile != null) {
        onSelectedImage(croppedFile);
      }
    }

    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                child: Text("Camera"),
                onPressed: () async {
                  final PickedFile file =
                      await picker.getImage(source: ImageSource.camera);
                  onSelectedImage(File(file.path));
                  cropImage(file.path);
                },
              ),
              TextButton(
                child: Text("Gallary"),
                onPressed: () async {
                  final PickedFile file =
                      await picker.getImage(source: ImageSource.gallery);
                  // onSelectedImage(File(file.path));
                  cropImage(file.path);
                },
              ),
            ],
          );
        },
      );
    else
      return CupertinoActionSheet(
        title: Text("Pick Image"),
        message: Text("Freeee pick"),
        cancelButton: CupertinoActionSheetAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text("Camera"),
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.camera);
              cropImage(file.path);
            },
          ),
          CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text("Gallary"),
            onPressed: () async {
              // final PickedFile file =
              //     await picker.getImage(source: ImageSource.gallery);

              final File selectFile = await setGalleryImage();

              cropImage(selectFile.path);
            },
          ),
        ],
      );
  }
}
