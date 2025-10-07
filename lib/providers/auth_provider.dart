import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/database_service.dart';

class AuthProvider extends ChangeNotifier {
  final _db = DatabaseService();
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Future<String?> register({required String name, required String email, required String password}) async {
    final usersBox = _db.usersBox;
    // Check existing email
    for (final key in usersBox.keys) {
      final user = User.fromMap(usersBox.get(key));
      if (user.email.toLowerCase() == email.toLowerCase()) {
        return 'Email already registered';
      }
    }
    final id = _db.generateId(prefix: 'usr_');
    final newUser = User(
      id: id,
      name: name,
      email: email,
      passwordHash: _hashPassword(password),
    );
    await usersBox.put(id, newUser.toMap());
    _currentUser = newUser;
    notifyListeners();
    return null; // success
  }

  Future<String?> login({required String email, required String password}) async {
    final usersBox = _db.usersBox;
    final ph = _hashPassword(password);
    for (final key in usersBox.keys) {
      final user = User.fromMap(usersBox.get(key));
      if (user.email.toLowerCase() == email.toLowerCase() && user.passwordHash == ph) {
        _currentUser = user;
        notifyListeners();
        return null;
      }
    }
    return 'Invalid email or password';
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}