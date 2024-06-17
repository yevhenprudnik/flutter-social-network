import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/login.dart';
import 'package:flutter_application_1/page/register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
          child: const Text('Log In'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 50),
          ),
          child: const Text('Register'),
        ),
      ],
    );
  }
}
