import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;
  Map<String, dynamic>? _user;
  String? _errorMessage; // Store error message

  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  Map<String, dynamic>? get user => _user;
  String? get errorMessage => _errorMessage; // Getter for error message

  void login(String token, Map<String, dynamic> user) {
    _isAuthenticated = true;
    _token = token;
    _user = user;
    _errorMessage = null; // Reset error message on successful login
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _token = null;
    _user = null;
    _errorMessage = null;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    
    notifyListeners();
  }
}
