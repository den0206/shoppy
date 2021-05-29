import 'package:flutter/services.dart';

String valideName(String value) {
  if (value.isEmpty) {
    return "Your Name";
  } else if (value.length < 3) {
    return "more 3";
  } else {
    return null;
  }
}

bool _isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

String validateEmail(String value) {
  if (value.isEmpty) {
    return "Please add in a email";
  } else if (!_isValidEmail(value)) {
    return "No email Regex";
  } else {
    return null;
  }
}

String validPassword(String value) {
  if (value.isEmpty) {
    return "Please add in a Passwrod";
  } else if (value.length < 6) {
    return "More Long Password(6)";
  } else {
    return null;
  }
}

String validPhone(String value) {
  if (value.isEmpty) {
    return "Fill";
  } else {
    return null;
  }
}

String validProductName(String value) {
  if (value.isEmpty) {
    return "Pelase enter a title";
  } else {
    return null;
  }
}

String validProductPrice(String value) {
  if (value.isEmpty) {
    return "Pelase enter a Price";
  } else {
    return null;
  }
}

String validProductDescription(String value) {
  if (value.isEmpty) {
    return "Pelase enter a Description";
  } else {
    return null;
  }
}

String validProductQuantity(String value) {
  if (value.isEmpty) {
    return "Pelase enter a Quantity";
  } else {
    return null;
  }
}

final List<TextInputFormatter> numberFormatter = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
];
