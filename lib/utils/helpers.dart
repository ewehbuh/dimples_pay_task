class Validators {
  /// Validates email format.
  static String? validateEmail(String email) {
    const emailRegex = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    if (email.isEmpty) {
      return "Email cannot be empty";
    } else if (!RegExp(emailRegex).hasMatch(email)) {
      return "Enter a valid email address";
    }
    return null; // Email is valid.
  }

  /// Validates password format.
  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Password cannot be empty";
    } else if (password.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null; // Password is valid.
  }
}
