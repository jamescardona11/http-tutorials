import 'dart:io';

import 'package:firebase_filledstacks_app/models/post_model.dart';
import 'package:firebase_filledstacks_app/services/cloud_storage_service.dart';
import 'package:firebase_filledstacks_app/services/dialog_service.dart';
import 'package:firebase_filledstacks_app/services/firestore_service.dart';
import 'package:firebase_filledstacks_app/services/navigation_service.dart';
import 'package:firebase_filledstacks_app/utils/image_selector.dart';
import 'package:firebase_filledstacks_app/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

import '../locator.dart';

class CreatePostViewModel extends BaseModel {
  Post _edittingPost;
  File _selectedImage;
  File get selectedImage => _selectedImage;

  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService = locator<CloudStorageService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future addPost({@required String title}) async {
    setBusy(true);

    CloudStorageResult storageResult;

    if (!_editting) {
      storageResult = await _cloudStorageService.uploadImage(imageToUpload: _selectedImage, title: title);
    }

    var result;
    if (!_editting) {
      result = await _firestoreService.addPost(Post(
          title: title,
          userId: currentUser.id,
          imageUrl: storageResult.imageUrl,
          imageFileName: storageResult.imageFileName));
    } else {
      result = await _firestoreService.updatePost(Post(
        title: title,
        userId: _edittingPost.userId,
        documentId: _edittingPost.documentId,
        imageUrl: _edittingPost.imageUrl,
        imageFileName: _edittingPost.imageFileName,
      ));
    }
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

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = tempImage;
      notifyListeners();
    }
  }

  void setEdittingPost(Post post) {
    _edittingPost = post;
  }

  bool get _editting => _edittingPost != null;
}
