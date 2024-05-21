import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/feed.dart';
import 'package:flutter_application_1/page/profile.dart';
import 'package:flutter_application_1/page/create_post.dart';
import 'package:flutter_application_1/page/login.dart';
import 'package:flutter_application_1/page/register.dart';
import 'package:flutter_application_1/state/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final String? uid = AppState.getUserId();

  static final List<Widget> _pages = <Widget>[
    const FeedPage(),
    const CreatePostPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppState.getUserId() == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              ),
            )
          : _pages[_selectedIndex],
      bottomNavigationBar: AppState.getUserId() == null
          ? null
          : BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.feed),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Create Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            ),
    );
  }
}
