import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
          r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$")
      .hasMatch(email);

  // RegExp(
  //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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

String validProductDescription(String value) {
  if (value.length < 6) {
    return "minimum 6";
  }

  return null;
}

String validProductPrice(String value) {
  if (value.isEmpty) {
    return "Pelase enter a Price";
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

String validCepAddress(String value) {
  if (value.isEmpty) {
    return "Is Empty";
  } else if (value.length != 8) {
    return "No 8";
  } else {
    return null;
  }
}

String validEmpty(String value) {
  if (value.isEmpty) {
    return "Is Empty";
  } else {
    return null;
  }
}

String validCreditCardNumber(String value) {
  if (value.length != 19) {
    return "Invalid";
  } else if (detectCCType(value) == CreditCardType.unknown) {
    return "Credit-Card Unknow";
  } else {
    return null;
  }
}

String validCreditCardDate(String value) {
  if (value.length != 7) {
    return "Invalid";
  } else {
    return null;
  }
}

String validCVV(String value) {
  if (value.length != 3) {
    return "Invalid CVV";
  } else {
    return null;
  }
}

final List<TextInputFormatter> numberFormatter = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
];
final List<TextInputFormatter> decimalFormatter = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*")),
];

final MaskTextInputFormatter dateFormatter = MaskTextInputFormatter(
    mask: '!#/####', filter: {'#': RegExp('[0-9]'), '!': RegExp('[0-1]')});
