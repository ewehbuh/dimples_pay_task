import 'package:dimples_task/providers/card_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/login_screen.dart';
import 'views/dashboard_screen.dart';
import 'utils/theme.dart';
import 'providers/auth_provider.dart';
import 'providers/nfc_card_provider.dart';

void main() {
  runApp(const DimplesTaskApp());
}

class DimplesTaskApp extends StatelessWidget {
  const DimplesTaskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NfcCardProvider()),
        ChangeNotifierProvider(create: (_) => CardDetailsProvider()),
        
      ],
      child: MaterialApp(
        title: 'Dimples Task',
        theme: AppTheme.getThemeData(),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(), // Default route
          '/dashboard': (context) => DashboardScreen(),
        },
      ),
    );
  }
}
