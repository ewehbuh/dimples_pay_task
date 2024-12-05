import 'package:dimples_task/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:dimples_task/controllers/auth_controller.dart';
import 'package:dimples_task/providers/auth_provider.dart';

void main() {
  testWidgets('LoginScreen widget test', (WidgetTester tester) async {
    // Mock AuthProvider
    final mockAuthProvider = AuthProvider();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: mockAuthProvider,
          child: LoginScreen(),
        ),
      ),
    );

    // Test Case 1: Check for validation error when email is empty
    expect(find.byType(TextField), findsNWidgets(2)); // Email and Password fields
    await tester.enterText(find.byType(TextField).at(0), ''); // Empty email
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Ensure validation error appears for email
    expect(find.text('Please enter a valid email address'), findsOneWidget);

    // Test Case 2: Check for validation error when password is empty
    await tester.enterText(find.byType(TextField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextField).at(1), ''); // Empty password
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Ensure validation error appears for password
    expect(find.text('Please enter a valid password'), findsOneWidget);

    // Test Case 3: Check if the loading indicator is shown during login process
    await tester.enterText(find.byType(TextField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Now simulate loading state by triggering a login attempt
     await tester.pump(); // Trigger rebuild

    // Check if the CircularProgressIndicator is visible while logging in
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Test Case 4: Check if error message is shown when login fails
    
    mockAuthProvider.setErrorMessage('Invalid credentials');
    await tester.pump();

    // Ensure the error message is displayed
    expect(find.text('Invalid credentials'), findsOneWidget);
  });
}
