import 'package:firebase_filledstacks_app/models/post_model.dart';
import 'package:firebase_filledstacks_app/services/dialog_service.dart';
import 'package:firebase_filledstacks_app/services/firestore_service.dart';
import 'package:firebase_filledstacks_app/services/navigation_service.dart';
import 'package:firebase_filledstacks_app/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

import '../locator.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future addPost({@required String title}) async {
    setBusy(true);
    var result = await _firestoreService
        .addPost(Post(title: title, userId: currentUser.id)); // We need to add the current userId
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not add Post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }

    _navigationService.pop();
  }
}
