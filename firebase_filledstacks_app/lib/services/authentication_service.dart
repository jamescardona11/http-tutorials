import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_filledstacks_app/locator.dart';
import 'package:firebase_filledstacks_app/models/user_models.dart';
import 'package:firebase_filledstacks_app/services/firestore_service.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  User _currentUser;
  User get currentUser => _currentUser;

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await _populateCurrentUser(authResult.user);

      return authResult != null;
    } catch (e) {
      return e;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String role,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await _firestoreService
          .createUser(User(id: authResult.user.uid, email: email.trim(), fullName: fullName, userRole: role));

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user); // Populate the user information
    return user != null;
  }
}
