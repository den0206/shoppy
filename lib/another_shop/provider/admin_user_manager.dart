import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:shoppy/Extension/firebaseRef.dart';
import 'package:shoppy/model/FBUser.dart';
import 'package:shoppy/provider/userState.dart';

class AdminUserManager with ChangeNotifier {
  List<FBUser> users = [];
  List<String> get names => users.map((u) => u.name).toList();

  StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void updateUsers(UserState userState) {
    _subscription?.cancel();
    if (adminEnable) {
      _listenToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    _subscription = firebaseReference(FirebaseRef.user).snapshots().listen(
      (snapshot) {
        users = snapshot.docs
            .map((document) => FBUser.fromDocument(document))
            .toList();

        users.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        notifyListeners();
      },
    );
  }

  void _listenToFakerUsers() {
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
