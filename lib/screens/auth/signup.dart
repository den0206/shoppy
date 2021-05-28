import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/Extension/validator.dart';
import 'package:shoppy/screens/auth/login.dart';

class SignUpPageModel with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordSecure = true;

  void changeSecure() {
    passwordSecure = !passwordSecure;
    notifyListeners();
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
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
