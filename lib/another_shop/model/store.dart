import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/another_shop/model/adress.dart';

enum StoreStatus { closed, open, closing }

extension StoreStatusExtention on StoreStatus {
  String get statusText {
    switch (this) {
      case StoreStatus.closed:
        return "Closed";
      case StoreStatus.open:
        return "Open";
      case StoreStatus.closing:
        return "Closing";
      default:
        return "";
    }
  }

  Color get colorForStatus {
    switch (this) {
      case StoreStatus.closed:
        return Colors.red;
      case StoreStatus.open:
        return Colors.green;
      case StoreStatus.closing:
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
}

class Store {
  String name;
  String image;
  String phone;
  Address address;
  Map<String, Map<String, TimeOfDay>> opening;

  StoreStatus status;

  String get cleanPhone => phone.replaceAll(RegExp(r"[^\d]"), "");

  String get addresText {
    return '${address.street}, ${address.number}${address.complement.isNotEmpty ? ' - ${address.complement}' : ''} - '
        ' ${address.city}/';
  }

  String get openingText {
    return 'Seg-Sex: ${formattedPeriod(opening[StoreKey.weekdays])}\n'
        'Sab: ${formattedPeriod(opening[StoreKey.saturday])}\n'
        'Dom: ${formattedPeriod(opening[StoreKey.sunday])}';
  }

  String formattedPeriod(Map<String, dynamic> period) {
    if (period == null) return "closed";
    return '${period[StoreKey.from].formatted()} - ${period[StoreKey.to].formatted()}';
  }

  Store.fromDocument(DocumentSnapshot doc) {
    name = doc[StoreKey.name];
    image = doc[StoreKey.image];
    phone = doc[StoreKey.phone];
    address = Address.fromMap(doc[StoreKey.address] as Map<String, dynamic>);

    opening = (doc[StoreKey.opening] as Map<String, dynamic>).map(
      (key, value) {
        final timeString = value as String;

        if (timeString != null && timeString.isNotEmpty) {
          final splitted = timeString.split(RegExp(r"[:-]"));

          return MapEntry(
            key,
            {
              StoreKey.from: TimeOfDay(
                  hour: int.parse(splitted[0]), minute: int.parse(splitted[1])),
              StoreKey.to: TimeOfDay(
                  hour: int.parse(splitted[2]), minute: int.parse(splitted[3]))
            },
          );
        } else {
          return MapEntry(key, null);
        }
      },
    );

    updateStatus();
  }

  void updateStatus() {
    final weekDay = DateTime.now().weekday;
    Map<String, TimeOfDay> period;

    if (weekDay >= 1 && weekDay <= 5) {
      period = opening[StoreKey.weekdays];
    } else if (weekDay == 6) {
      period = opening[StoreKey.saturday];
    } else {
      period = opening[StoreKey.sunday];
    }

    final now = TimeOfDay.now();

    if (period == null) {
      status = StoreStatus.closed;
    } else if (period[StoreKey.from].toMinutes() < now.toMinutes() &&
        period[StoreKey.to].toMinutes() - 15 > now.toMinutes()) {
      status = StoreStatus.open;
    } else if (period[StoreKey.from].toMinutes() < now.toMinutes() &&
        period[StoreKey.to].toMinutes() > now.toMinutes()) {
      status = StoreStatus.closing;
    } else {
      status = StoreStatus.closed;
    }
  }
}

class StoreKey {
  static final name = "name";
  static final image = "image";
  static final phone = "phone";
  static final address = "address";
  static final opening = "opening";

  static final weekdays = "weekdays";
  static final saturday = "saturday";
  static final sunday = "sunday";

  static final from = "from";
  static final to = "to";
}

extension Extra on TimeOfDay {
  String formatted() {
    return '${hour}h${minute.toString().padLeft(2, '0')}';
  }

  int toMinutes() => hour * 60 + minute;
}
