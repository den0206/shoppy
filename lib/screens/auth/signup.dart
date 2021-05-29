import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/Extension/validator.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/screens/auth/login.dart';

class SignUpPageModel with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File userImage;

  bool passwordSecure = true;

  void changeSecure() {
    passwordSecure = !passwordSecure;
    notifyListeners();
  }

  Future assetImage(BuildContext context) async {
    List<Asset> resultList = <Asset>[];

    try {
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

      var path2 = await FlutterAbsolutePath.getAbsolutePath(
          resultList.first.identifier);
      final file = File(path2);
      userImage = file;
      notifyListeners();
      Navigator.of(context).pop();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future cameraImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickImage.path);
    userImage = pickedImageFile;
    notifyListeners();
    Navigator.of(context).pop();
  }

  void removeImage(BuildContext context) {
    userImage = null;
    notifyListeners();
    Navigator.of(context).pop();
  }
}

class SignupPage extends StatelessWidget {
  SignupPage({Key key}) : super(key: key);
  static const routeName = '/SignUpScreen';
  final _formKey = GlobalKey<FormState>(debugLabel: '_SignUpState');

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Wave(),
          ChangeNotifierProvider<SignUpPageModel>(
            create: (context) => SignUpPageModel(),
            builder: (context, snapshot) {
              return Consumer<SignUpPageModel>(
                builder: (context, model, child) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                            ),
                            _AvatarSpace(model: model),
                            CustomTextFields(
                              controller: model.nameController,
                              labelText: "Name",
                              inputType: TextInputType.text,
                              validator: valideName,
                              inputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_emailFocusNode),
                              onChange: (value) => model.nameController,
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextFields(
                              controller: model.emailController,
                              labelText: "Email",
                              inputType: TextInputType.emailAddress,
                              validator: validateEmail,
                              inputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode),
                              onChange: (value) => model.emailController,
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextFields(
                              controller: model.passwordController,
                              focusNode: _passwordFocusNode,
                              isSecure: model.passwordSecure,
                              labelText: "Password",
                              inputType: null,
                              validator: validPassword,
                              onChange: (value) => model.passwordController,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_phoneNumberFocusNode),
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                onPressed: model.changeSecure,
                                icon: Icon(model.passwordSecure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextFields(
                              controller: model.phoneController,
                              labelText: "Phone",
                              inputType: TextInputType.phone,
                              validator: validPhone,
                              inputAction: TextInputAction.next,
                              onChange: (value) => model.phoneController,
                              prefixIcon: Icon(
                                Icons.phone_android,
                              ),
                              onEditingComplete: () {
                                print("Sign up");
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomIconButton(
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Feather.user,
                                    size: 18,
                                  )
                                ],
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  FocusScope.of(context).unfocus();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          BackButtonWithStack(),
        ],
      ),
    );
  }
}

class _AvatarSpace extends StatelessWidget {
  const _AvatarSpace({
    Key key,
    @required this.model,
  }) : super(key: key);

  final SignUpPageModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: CircleAvatar(
              radius: 71,
              backgroundColor: ColorsConsts.gradiendLEnd,
              backgroundImage:
                  model.userImage == null ? null : FileImage(model.userImage)),
        ),
        Positioned(
          top: 120,
          left: 110,
          child: RawMaterialButton(
            elevation: 10,
            fillColor: ColorsConsts.gradiendLEnd,
            child: Icon(Icons.add_a_photo),
            padding: EdgeInsets.all(15),
            shape: CircleBorder(),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "Choose option",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ColorsConsts.gradiendLStart,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          InkWell(
                            splashColor: Colors.purpleAccent,
                            onTap: () {
                              model.cameraImage(context);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.camera,
                                      color: Colors.purpleAccent),
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: ColorsConsts.title),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.purpleAccent,
                            onTap: () {
                              model.assetImage(context);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.image,
                                      color: Colors.purpleAccent),
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: ColorsConsts.title),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.purpleAccent,
                            onTap: () {
                              model.removeImage(context);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.remove_circle,
                                      color: Colors.purpleAccent),
                                ),
                                Text(
                                  "Remove",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
