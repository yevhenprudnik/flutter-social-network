import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/post.service.dart';
import 'package:flutter_application_1/services/user.service.dart';
import 'package:flutter_application_1/state/global.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  User? user;
  final _formKey = GlobalKey<FormState>();
  String _postTitle = '';
  String _imgUrl = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Post Title'),
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
                decoration: const InputDecoration(labelText: 'Img Url'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imgUrl = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await PostService().createPost(user!, _imgUrl, _postTitle);
                    _formKey.currentState!.reset();
                  }
                },
                child: const Text('Create Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
