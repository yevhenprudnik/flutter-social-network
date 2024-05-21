import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/post.service.dart';
import 'package:flutter_application_1/services/user.service.dart';
import 'package:flutter_application_1/state/global.dart';
import 'package:flutter_application_1/component/post_cart.dart';

class ProfilePage extends StatefulWidget {
  final String? uid;
  const ProfilePage({Key? key, this.uid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final uid = widget.uid ?? AppState.getUserId();
    if (uid == null) {
      return;
    }

    User? currentUser = await UserService().getUser(uid);

    if (currentUser != null) {
      setState(() {
        user = currentUser;
      });

      List<Post> userPosts = await PostService().getUserPosts(currentUser.uid);
      setState(() {
        posts = userPosts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
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
                  if (user!.profileDescription != null &&
                      user!.profileDescription!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Profile Description: \n${user!.profileDescription}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    'User Posts:',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children:
                        posts.map((post) => PostCard(post: post)).toList(),
                  ),
                ],
              ),
      ),
    );
  }
}
