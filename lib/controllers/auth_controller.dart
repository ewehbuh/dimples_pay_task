import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../providers/auth_provider.dart';

class AuthController {
  Future<void> login(String email, String password, BuildContext context) async {
    try {
      final response = await ApiService.login(email, password);

      final String token = response['token'];
      final Map<String, dynamic> user = response['user'];

      // Update the global state via AuthProvider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.login(token, user);

      // Navigate to the dashboard after successful login
      Navigator.pushReplacementNamed(context, '/dashboard', arguments: user);
    } on NetworkError catch (e) {
      // Handle network-related errors (no internet, timeout)
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.setErrorMessage(e.message); // Store error message
    } catch (error) {
      // Handle general errors like invalid credentials
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.setErrorMessage(error.toString()); // Store error message
    }
  }
}
