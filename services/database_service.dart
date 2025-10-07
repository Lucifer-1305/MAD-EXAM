import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  Future<void> init() async {
    await Hive.openBox('users');
    await Hive.openBox('places');
    await Hive.openBox('tickets');
  }

  Box get usersBox => Hive.box('users');
  Box get placesBox => Hive.box('places');
  Box get ticketsBox => Hive.box('tickets');

  String generateId({String prefix = ''}) {
    final millis = DateTime.now().millisecondsSinceEpoch;
    final rnd = Random().nextInt(999999);
    return '$prefix$millis$rnd';
  }

  String generateTicketNumber() {
    final millis = DateTime.now().millisecondsSinceEpoch;
    final rnd = Random().nextInt(9999).toString().padLeft(4, '0');
    return 'GJ-$millis-$rnd';
  }
}