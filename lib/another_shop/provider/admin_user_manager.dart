import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:shoppy/model/FBUser.dart';
import 'package:shoppy/provider/userState.dart';

class AdminUserManager with ChangeNotifier {
  List<FBUser> users = [];
  List<String> get names => users.map((u) => u.name).toList();

  void updateUsers(UserState userState) {
    if (currentUser != null) {
      _listenToUsetrs();
    }
  }

  void _listenToUsetrs() {
    final faker = Faker();

    for (int i = 0; i < 1000; i++) {
      users.add(FBUser(
        name: faker.person.name(),
        email: faker.internet.email(),
      ));
    }

    users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    notifyListeners();
  }
}
