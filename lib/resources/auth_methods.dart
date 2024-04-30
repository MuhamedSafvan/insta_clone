import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return UserModel.fromSnap(snap);
  }

  signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Something went wrong";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //user registration
        final cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        final user = UserModel(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl);

        // storing user credentials
        await _firestore
            .collection('users')
            .doc(cred.user?.uid)
            .set(user.toJson());
        res = "success";
      }
    }
    //  on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = 'The email address is badly formatted';
    //   } else if (err.code == 'weak-password') {
    //     res = 'Password should be at least 6 characters';
    //   }
    // }
    catch (e) {
      res = e.toString();
    }
    return res;
  }

  // login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Something went wrong";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //user registration
        final cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      res = e.message!;
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
