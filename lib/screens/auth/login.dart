import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/Extension/validator.dart';
import 'package:shoppy/consts/colors.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginPageModel with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordSecure = true;

  String get _email => emailController.text;
  String get _password => passwordController.text;

  void changeSecure() {
    passwordSecure = !passwordSecure;
    notifyListeners();
  }
}

class LoginPgge extends StatelessWidget {
  LoginPgge({Key key}) : super(key: key);

  static const routeName = "/LoginPage";
  final _formKey = GlobalKey<FormState>(debugLabel: '_LoginState');
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Wave(),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://image.flaticon.com/icons/png/128/869/869636.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ChangeNotifierProvider<LoginPageModel>(
                create: (context) => LoginPageModel(),
                builder: (context, snapshot) {
                  return Consumer<LoginPageModel>(
                    builder: (context, model, child) {
                      return Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
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
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: model.changeSecure,
                                  icon: Icon(model.passwordSecure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                onEditingComplete: () {
                                  print("Login");
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
                                      'Login',
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
          BackButtonWithStack(),
        ],
      ),
    );
  }
}

class Wave extends StatelessWidget {
  const Wave({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      child: RotatedBox(
        quarterTurns: 2,
        child: WaveWidget(
          config: CustomConfig(
            gradients: [
              [
                ColorsConsts.gradiendFStart,
                ColorsConsts.gradiendLStart,
              ],
              [
                ColorsConsts.gradiendFEnd,
                ColorsConsts.gradiendLEnd,
              ],
            ],
            durations: [19440, 10800],
            heightPercentages: [0.20, 0.25],
            blur: MaskFilter.blur(BlurStyle.solid, 10),
            gradientBegin: Alignment.bottomLeft,
            gradientEnd: Alignment.topRight,
          ),
          waveAmplitude: 0,
          size: Size(
            double.infinity,
            double.infinity,
          ),
        ),
      ),
    );
  }
}
