import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/post.service.dart';
import 'package:flutter_application_1/services/user.service.dart';
import 'package:flutter_application_1/state/global.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final uid = AppState.getUserId();
    if (uid == null) {
      return;
    }

    User? currentUser = await UserService().getUser(uid);

    if (currentUser != null) {
      setState(() {
        user = currentUser;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  String _postTitle = '';
  String _imgUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: user == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(user!.avatar),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Username: ${user!.username}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${user!.email}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Profile Description: \n${user!.profileDescription}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Post Title'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _postTitle = value!;
                          },
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Img Url'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _imgUrl = value!;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Validate form
                            if (_formKey.currentState!.validate()) {
                              // Save form
                              _formKey.currentState!.save();
                              // Call a method to create a post
                              PostService().createPost(user!, _imgUrl, _postTitle);
                            }
                          },
                          child: const Text('Create Post'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
