import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String username;
  final String description;
  final String uid;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const PostModel({
    required this.username,
    required this.description,
    required this.uid,
    required this.postId,
    required this.datePublished,
    required this.profImage,
    required this.likes,
    required this.postUrl,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "description": description,
        "uid": uid,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profImage": profImage,
        "likes": likes
      };

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      username: snapshot['username'],
      description: snapshot['description'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
    );
  }
}
