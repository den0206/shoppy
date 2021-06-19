import 'package:credit_card_type_detector/credit_card_type_detector.dart';

class CreditCard {
  String number;
  String holder;
  String expirationDate;
  String securityCode;

  String brand;
  void setHoler(String value) => holder = value;
  void setExpirationDate(String value) => expirationDate = value;
  void setCVV(String value) => securityCode = value;
  void setNumber(String value) {
    this.number = number;
    brand = detectCCType(number.replaceAll(" ", ""))
        .toString()
        .toUpperCase()
        .split(".")
        .last;
  }
}
