import 'package:flutter_application_1/infra/firestore.data.dart';
import 'package:flutter_application_1/models/post.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/user.service.dart';

class PostService {
  final FirestoreDataService _firestoreService = FirestoreDataService();

  Future<List<Post>> getPosts() async {
    return _firestoreService.getCollection<Post>(
      'post',
      (data) => Post.fromDocumentSnapshot(data),
    );
  }

  Future<List<Post>> getUserPosts(String authorUid) async {
    List<Post> posts = await _firestoreService.getCollection<Post>(
      'post',
      (data) => Post.fromDocumentSnapshot(data),
      field: 'authorUid',
      value: authorUid,
    );
    User? user = await UserService().getUser(authorUid);

    List<Post> userPosts = posts.map((post) {
      post.authorAvatar = user?.avatar;
      return post;
    }).toList();

    return userPosts;
  }

  Future<List<Post>> getPostsWithUser() async {
    List<Post> posts = await _firestoreService.getCollection<Post>(
      'post',
      (data) => Post.fromDocumentSnapshot(data),
    );

    List<Future<Post>> futurePosts = posts.map((post) async {
      User? user = await UserService().getUser(post.authorUid);
      post.authorAvatar = user?.avatar;
      return post;
    }).toList();

    return Future.wait(futurePosts);
  }

  Future<void> createPost(
    User user,
    String imgUrl,
    String postTitle,
  ) async {
    Post newPost = Post(
      img: imgUrl,
      title: postTitle,
      authorUid: user.uid,
      timestamp: DateTime.now(),
    );
    await _firestoreService.createDocument('post', newPost);
  }
}
