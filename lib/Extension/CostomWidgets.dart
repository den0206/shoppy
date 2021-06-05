import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackButtonWithStack extends StatelessWidget {
  const BackButtonWithStack({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        title: Text(''), // You can add title here
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent, //You can make this transparent
        elevation: 0.0, //No shadow
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  const GradientIcon({
    Key key,
    this.icon,
    this.size,
    this.gradient,
  }) : super(key: key);

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
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
    this.inputFormatter,
    this.enable,
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
  final bool enable;

  final List<TextInputFormatter> inputFormatter;

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
        // fillColor: Theme.of(context).backgroundColor,
      ),
      keyboardType: inputType,
      enabled: enable,
      textInputAction: inputAction,
      validator: validator,
      onEditingComplete: onEditingComplete,
      onChanged: onChange,
      obscureText: isSecure,
      inputFormatters: inputFormatter,
    );
  }
}

class OverlayLoadingWidget extends StatelessWidget {
  const OverlayLoadingWidget({
    Key key,
    @required this.child,
    @required this.isLoading,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        if (isLoading)
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    decoration: TextDecoration.none,
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
