import 'package:flutter/material.dart';
import 'package:flutter_integration_test/pages/home_page.dart';
import 'package:flutter_integration_test/pages/login_page.dart';
import 'package:flutter_integration_test/services/auth_service.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator.adaptive()),
              );
            } else if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        );
      },
    );
  }
}
