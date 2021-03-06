import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/Extension/ImagePickerFunction.dart';
import 'package:shoppy/Extension/StoregeFunction.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/Extension/global_function.dart';
import 'package:shoppy/Extension/validator.dart';
import 'package:shoppy/model/category.dart';
import 'package:shoppy/model/popular_brand.dart';
import 'package:shoppy/model/product.dart';

class UploadProductModel with ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  String get title => titleController.text;
  int get price => int.parse(priceController.text);
  String get description => descriptionController.text;
  int get quantity => int.parse(quantityController.text);

  KCategory selectCategoey;
  Brand selectBrand;
  File productImage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void changeCategory(KCategory value) {
    selectCategoey = value;
    notifyListeners();
  }

  void changeBland(Brand value) {
    selectBrand = value;
    notifyListeners();
  }

  Future assetImage() async {
    try {
      final file = await setGalleryImage();
      productImage = file;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future cameraImage() async {
    final file = await openCamera();
    productImage = file;
    notifyListeners();
  }

  void removeImage(BuildContext context) {
    productImage = null;
    notifyListeners();
  }

  void submitProduct({
    @required void Function() onSuccess,
    @required void Function(Exception e) errorCallback,
  }) async {
    if (productImage == null) {
      Exception noImgeError = Exception("No Production Image");
      errorCallback(noImgeError);
      return;
    }

    isLoading = true;

    try {
      final doc = firebaseReference(FirebaseRef.product).doc();
      final productId = doc.id;

      final imageUrl = await uploadStorage(
          StorageRef.productImage, "$productId.jpg", productImage);

      final Product product = Product(
        id: productId,
        title: title,
        description: description,
        price: double.parse(priceController.text),
        imageUrl: imageUrl,
        category: selectCategoey ?? KCategory.all,
        brand: selectBrand ?? Brand.all,
      );

      await doc.set(product.toMap1());

      onSuccess();

      // continue;
    } catch (e) {
      errorCallback(e);
    } finally {
      print("Finish");

      isLoading = false;
    }
  }
}

class UploadProductPage extends StatelessWidget {
  UploadProductPage({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>(debugLabel: '_ProductState');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UploadProductModel>(
        create: (context) => UploadProductModel(),
        builder: (context, snapshot) {
          return Consumer<UploadProductModel>(builder: (_, model, __) {
            return OverlayLoadingWidget(
              isLoading: model.isLoading,
              child: Scaffold(
                bottomNavigationBar: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  child: Material(
                    color: Theme.of(context).backgroundColor,
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          FocusScope.of(context).unfocus();

                          model.submitProduct(
                            onSuccess: () {
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null;
                            },
                            errorCallback: (Exception e) {
                              showErrorAlert(context, e);
                            },
                          );
                        }
                      },
                      splashColor: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: Text(
                              "Upload",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          GradientIcon(
                            icon: Feather.upload,
                            size: 20,
                            gradient: LinearGradient(
                              colors: [
                                Colors.green,
                                Colors.yellow,
                                Colors.deepOrange,
                                Colors.orange,
                                Colors.yellow[800]
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        margin: EdgeInsets.all(15),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: CustomTextFields(
                                        controller: model.titleController,
                                        labelText: "Product Title",
                                        validator: validProductName,
                                        inputType: TextInputType.text,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: CustomTextFields(
                                        controller: model.priceController,
                                        labelText: "Price \$",
                                        validator: validProductPrice,
                                        inputType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatter: decimalFormatter,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: model.productImage == null
                                          ? Container(
                                              margin: EdgeInsets.all(10),
                                              height: 200,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                              ),
                                            )
                                          : Container(
                                              margin: EdgeInsets.all(10),
                                              height: 200,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                              ),
                                              child: Image.file(
                                                model.productImage,
                                                fit: BoxFit.contain,
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          child: CustomIconButton(
                                            onPressed: () {
                                              model.cameraImage();
                                            },
                                            backColor: Theme.of(context)
                                                .backgroundColor,
                                            widget: Row(
                                              children: [
                                                Icon(Icons.camera,
                                                    color: Colors.purpleAccent),
                                                Text(
                                                  'Camera',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FittedBox(
                                          child: CustomIconButton(
                                            onPressed: () {
                                              model.assetImage();
                                            },
                                            backColor: Theme.of(context)
                                                .backgroundColor,
                                            widget: Row(
                                              children: [
                                                Icon(Icons.image,
                                                    color: Colors.purpleAccent),
                                                Text(
                                                  'Gallery',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FittedBox(
                                          child: CustomIconButton(
                                            onPressed: () {
                                              model.removeImage(context);
                                            },
                                            backColor: Theme.of(context)
                                                .backgroundColor,
                                            widget: Row(
                                              children: [
                                                Icon(
                                                    Icons.remove_circle_rounded,
                                                    color: Colors.purpleAccent),
                                                Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DropdownButton<KCategory>(
                                      items: [
                                        for (KCategory category in categories)
                                          DropdownMenuItem(
                                            child: Text(category.name),
                                            value: category,
                                          )
                                      ],
                                      onChanged: model.changeCategory,
                                      hint: Text("Select Category"),
                                      value: model.selectCategoey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton<Brand>(
                                      items: [
                                        for (Brand brand in brands)
                                          DropdownMenuItem(
                                            child: Text(brand.name),
                                            value: brand,
                                          )
                                      ],
                                      onChanged: model.changeBland,
                                      hint: Text("Select Brand"),
                                      value: model.selectBrand,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: model.descriptionController,
                                  maxLines: 10,
                                  validator: validProductDescription,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    labelText: "Description",
                                    hintText: "Product Description",
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) =>
                                      model.descriptionController,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 9),
                                        child: TextFormField(
                                          controller: model.quantityController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: numberFormatter,
                                          validator: validProductQuantity,
                                          decoration: InputDecoration(
                                            labelText: "Quantity",
                                          ),
                                          onChanged: (value) =>
                                              model.quantityController,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
