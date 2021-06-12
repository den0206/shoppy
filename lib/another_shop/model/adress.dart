import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  String capital;
  String city;
  String street;

  String number;
  String complement;

  Address.fromJson(Map<String, dynamic> map) {
    capital = map["results"][0]["address1"];
    city = map["results"][0]["address2"];
    street = map["results"][0]["address3"];
  }

  Address.fromDocument(DocumentSnapshot doc) {
    capital = doc[AddressKey.capital];
    city = doc[AddressKey.city];
    street = doc[AddressKey.street];
    number = doc[AddressKey.number];
    if (doc[AddressKey.complement]) complement = doc[AddressKey.complement];
  }

  Map<String, dynamic> toMap() {
    return {
      AddressKey.capital: capital,
      AddressKey.city: city,
      AddressKey.street: street,
      AddressKey.number: number,
      AddressKey.complement: complement,
    };
  }
}

class AddressKey {
  static final capital = "capital";
  static final city = "city";
  static final street = "street";
  static final number = "number";
  static final complement = "complement";
}
