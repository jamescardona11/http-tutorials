import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_filledstacks_app/models/post_model.dart';
import 'package:firebase_filledstacks_app/models/user_models.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference = Firestore.instance.collection("users");
  final CollectionReference _postsCollectionReference = Firestore.instance.collection('posts');

  final StreamController<List<Post>> _postController = StreamController<List<Post>>.broadcast();

  Stream listenToPostsRealTime() {
    _postsCollectionReference.snapshots().listen((postSnapshot) {
      if (postSnapshot.documents.isNotEmpty) {
        var posts = postSnapshot.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((element) => element.title != null)
            .toList();

        _postController.add(posts);
      }
    });

    return _postController.stream;
  }

  Future deletePost(String documentId) async {
    await _postsCollectionReference.document(documentId).delete();
  }

  Future addPost(Post post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
  }

  Future getPostsOnceOff() async {
    try {
      var postDocuments = await _postsCollectionReference.getDocuments();
      if (postDocuments.documents.isNotEmpty) {
        return postDocuments.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
