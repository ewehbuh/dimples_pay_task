import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../providers/auth_provider.dart';
import '../utils/helpers.dart';
import '../utils/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  bool isLoading = false;

  void _validateAndLogin() async {
    setState(() {
      emailError = Validators.validateEmail(emailController.text.trim());
      passwordError = Validators.validatePassword(passwordController.text.trim());
    });

    if (emailError == null && passwordError == null) {
      setState(() {
        isLoading = true;
      });

      try {
        await AuthController().login(
          emailController.text.trim(),
          passwordController.text.trim(),
          context,
        );
      } catch (error) {
        // Handle error display after login
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final loginError = authProvider.errorMessage;

        if (loginError != null) {
          // Display error using FlutterToast with customized style
          Fluttertoast.showToast(
            msg: loginError,
            toastLength: Toast.LENGTH_LONG, // Make it stay for longer
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red, // Background color
            textColor: Colors.white, // Text color
            fontSize: 16.0, // Font size
            timeInSecForIosWeb: 4, // Time to disappear on iOS (4 seconds)
          );
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Dimples Task",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Log in to continue",
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 32),

                // Check if errorMessage is not null and display it
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    if (authProvider.errorMessage != null) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          authProvider.errorMessage!,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      );
                    } else {
                      return Container(); // No error message to display
                    }
                  },
                ),

                if (emailError != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      emailError!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorText: emailError,
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorText: passwordError,
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: isLoading ? null : _validateAndLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          "Log In",
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
