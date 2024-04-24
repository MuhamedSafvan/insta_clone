import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/posts.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // login user
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Something went wrong";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      final postId = const Uuid().v1();
      final post = PostModel(
        username: username,
        description: description,
        uid: uid,
        postId: postId,
        datePublished: DateTime.now(),
        profImage: profImage,
        likes: [],
        postUrl: photoUrl,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
