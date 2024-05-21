import 'package:flutter_application_1/models/abstract.model.dart';

class Post extends Model {
  final String img;
  final String title;
  final String authorUid;
  String? authorAvatar;
  final DateTime timestamp;

  Post({
    required this.img,
    required this.title,
    required this.authorUid,
    required this.timestamp,
    this.authorAvatar,
  }) : super.fromDocumentSnapshot({});

  @override
  Post.fromDocumentSnapshot(super.doc)
      : img = doc['img'],
        title = doc['title'],
        authorUid = doc['authorUid'],
        authorAvatar = doc['authorAvatar'],
        timestamp = doc['timestamp'].toDate(),
        super.fromDocumentSnapshot();

  @override
  Map<String, dynamic> toMap() {
    return {
      'img': img,
      'title': title,
      'authorUid': authorUid,
      'authorAvatar': authorAvatar,
      'timestamp': timestamp,
    };
  }
}
