import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:shoppy/consts/colors.dart';
import 'package:shoppy/model/FBUser.dart';
import 'package:shoppy/screens/auth/login.dart';

class SignUpPageModel with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  File userImage;

  final _auth = FirebaseAuth.instance;
  String get name => nameController.text;
  String get password => passwordController.text;
  String get email => emailController.text.toLowerCase().trim();
  int get phone => int.parse(phoneController.text.trim());

  bool isLoading = false;
  bool passwordSecure = true;

  Future<void> signUpUser({
    @required void Function(FBUser user) onSuccess,
    @required void Function(Exception e) errorCallback,
  }) async {
    if (userImage == null) {
      Exception error = Exception("No Image");
      errorCallback(error);

      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (_credential != null) {
        final uid = _credential.user.uid;

        String imageUrl =
            await uploadStorage(StorageRef.userImage, "$uid", userImage);

        FBUser user = FBUser(
          uid: uid,
          name: name,
          email: email,
          imageUrl: imageUrl,
        );

        firebaseReference(FirebaseRef.user)
            .doc(user.uid)
            .set(user.toMap())
            .whenComplete(() {
          onSuccess(user);
        });
      }
    } catch (e) {
      errorCallback(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeSecure() {
    passwordSecure = !passwordSecure;
    notifyListeners();
  }

  Future assetImage(BuildContext context) async {
    try {
      final file = await setGalleryImage();
      userImage = file;
      notifyListeners();
      Navigator.of(context).pop();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future cameraImage(BuildContext context) async {
    final file = await openCamera();
    userImage = file;
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
      body: GestureDetector(
        onTap: () {
          dismissKeybourd(context);
        },
        child: Stack(
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
                                inputFormatter: numberFormatter,
                                inputAction: TextInputAction.next,
                                onChange: (value) => model.phoneController,
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                ),
                                onEditingComplete: () {
                                  if (_formKey.currentState.validate()) {
                                    FocusScope.of(context).unfocus();
                                    model.signUpUser(
                                      onSuccess: (user) {},
                                      errorCallback: (e) {
                                        showErrorAlert(context, e);
                                      },
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomIconButton(
                                isLoading: model.isLoading,
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

                                    model.signUpUser(
                                      onSuccess: (user) {
                                        if (Navigator.canPop(context))
                                          Navigator.pop(context);
                                      },
                                      errorCallback: (e) {
                                        showErrorAlert(context, e);
                                      },
                                    );
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
