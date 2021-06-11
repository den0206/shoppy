class Address {
  String capital;
  String city;
  String town;

  Address.fromMap(Map<String, dynamic> map) {
    capital = map["results"][0]["address1"];
    city = map["results"][0]["address2"];
    town = map["results"][0]["address3"];
  }
}
