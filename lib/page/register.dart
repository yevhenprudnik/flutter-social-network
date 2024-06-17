import 'package:flutter/material.dart';
import 'package:flutter_application_1/infra/firebase.auth.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/user.service.dart';
import 'package:flutter_application_1/state/global.dart';

import 'home.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();
  final TextEditingController _profileDescriptionController = TextEditingController(); // New Controller
  final FirebaseAuthService _authService = FirebaseAuthService();

  bool _isLoading = false;

  void _register(final BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;
    String username = _usernameController.text;
    String avatar = _avatarController.text;
    String profileDescription = _profileDescriptionController.text; // Get Profile Description

    AuthResult? result = await _authService.signUp(email, password);
    setState(() {
      _isLoading = false;
    });

    if (result.error != null) {
      _showAlert('Registration failed: ${result.error}');
    } else {
      await UserService().createUser(User(
          uid: result.user!.uid,
          username: username,
          email: email,
          avatar: avatar,
          profileDescription: profileDescription // Set Profile Description
      ));
      AppState.setUserId(result.user!.uid);
    if(context.mounted) {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
    }
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Register'),
        centerTitle: true,
      ),
      body:  Padding(
        padding:const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _avatarController,
                  decoration: InputDecoration(
                    labelText: 'Avatar Url',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(Icons.image),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _profileDescriptionController, // New TextField
                  decoration: InputDecoration(
                    labelText: 'Profile Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(Icons.description),
                  ),
                ),
                const SizedBox(height: 20.0),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => _register(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 80.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Sign Up',
                            style: TextStyle(fontSize: 16.0)),
                      ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
      ),
      
    );
  }
}
