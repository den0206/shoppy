import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.height = 50,
    this.width = 200,
    @required this.title,
    this.isLoading = false,
    this.titleColor = Colors.white,
    this.backColor = Colors.green,
    @required this.onPressed,
  }) : super(key: key);
  final double height;
  final double width;

  final String title;
  final bool isLoading;
  final Color titleColor;
  final Color backColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: backColor,
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: !isLoading
              ? Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                  ),
                )
              : CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
          onPressed: !isLoading ? onPressed : null),
    );
  }
}
