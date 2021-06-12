import 'package:flutter/material.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/screens/auth/login.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.account_circle,
                size: 100,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "not yet Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              CustomButton(
                title: "Go To Login",
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginPgge.routeName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
