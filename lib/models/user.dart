import 'package:flutter_application_1/models/abstract.model.dart';

class User extends Model {
  final String uid;
  final String username;
  final String email;
  final String avatar;
  final String? profileDescription;

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.avatar,
    this.profileDescription,
  }) : super.fromDocumentSnapshot({});

  @override
  User.fromDocumentSnapshot(super.doc)
      : uid = doc['uid'],
        username = doc['username'],
        email = doc['email'],
        avatar = doc['avatar'],
        profileDescription = doc['profileDescription'],
        super.fromDocumentSnapshot();

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'avatar': avatar,
      'profileDescription': profileDescription,
    };
  }
}
