import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/feed.dart';
import 'package:flutter_application_1/page/login.dart';
import 'package:flutter_application_1/page/profile.dart';
import 'package:flutter_application_1/page/register.dart';
import 'package:flutter_application_1/state/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Heap"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: AppState.getUserId() == null
              ? [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50)),
                    child: const Text('Log In'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text('Register'),
                  ),
                ]
              : [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FeedPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50)),
                    child: const Text('Feed'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50)),
                    child: const Text('Profile'),
                  ),
                ],
        ),
      ),
    );
  }
}
