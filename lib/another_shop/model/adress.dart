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

  Address.fromMap(Map<String, dynamic> map) {
    capital = map[AddressKey.capital];
    city = map[AddressKey.city];
    street = map[AddressKey.street];
    number = map[AddressKey.number];
    if (map[AddressKey.complement] != null)
      complement = map[AddressKey.complement];
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
