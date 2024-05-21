import 'package:flutter_application_1/infra/firestore.data.dart';
import 'package:flutter_application_1/models/user.dart';

class UserService {
  final FirestoreDataService _firestoreService = FirestoreDataService();

  Future<User?> getUser(String uid) async {
    return _firestoreService.getDocument<User>(
      'user',
      'uid',
      uid,
      (data) => User.fromDocumentSnapshot(data),
    );
  }

  Future<List<User>> getUsers() async {
    return _firestoreService.getCollection<User>(
      'user',
      (data) => User.fromDocumentSnapshot(data),
    );
  }

  Future<void> createUser(User user) async {
    await _firestoreService.createDocument('user', user);
  }
}
