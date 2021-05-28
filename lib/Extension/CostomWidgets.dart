import 'package:flutter/material.dart';

void navigateTo(BuildContext ctx, String routeName) {
  Navigator.of(ctx).pushNamed(
    routeName,
  );
}

Future showAlert(
  BuildContext context,
  String title,
  String subtitle,
  Function() ontap,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Image.network(
                'https://image.flaticon.com/icons/png/128/564/564619.png',
                height: 20,
                width: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title),
            ),
          ],
        ),
        content: Text(subtitle),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
              onPressed: () {
                ontap();
                Navigator.pop(context);
              },
              child: Text('ok'))
        ],
      );
    },
  );
}

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

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key key,
    this.height = 50,
    this.width = 200,
    @required this.widget,
    this.isLoading = false,
    this.titleColor = Colors.white,
    this.backColor = Colors.green,
    @required this.onPressed,
  }) : super(key: key);
  final double height;
  final double width;

  final Widget widget;
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
            onPrimary: titleColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: !isLoading
              ? widget
              : CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
          onPressed: !isLoading ? onPressed : null),
    );
  }
}

class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    Key key,
    @required this.controller,
    @required this.labelText,
    this.inputType = TextInputType.text,
    this.isSecure = false,
    this.validator,
    this.onChange,
    this.inputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.onEditingComplete,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType inputType;
  final bool isSecure;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChange;
  final Function() onEditingComplete;
  final TextInputAction inputAction;
  final FocusNode focusNode;

  final Widget prefixIcon;
  final Widget suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        // filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        fillColor: Theme.of(context).backgroundColor,
      ),
      keyboardType: inputType,
      textInputAction: inputAction,
      validator: validator,
      onEditingComplete: onEditingComplete,
      onChanged: onChange,
      obscureText: isSecure,
    );
  }
}
