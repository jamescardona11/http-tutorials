import 'package:firebase_filledstacks_app/constants/route_names.dart';
import 'package:firebase_filledstacks_app/locator.dart';
import 'package:firebase_filledstacks_app/models/post_model.dart';
import 'package:firebase_filledstacks_app/services/dialog_service.dart';
import 'package:firebase_filledstacks_app/services/firestore_service.dart';
import 'package:firebase_filledstacks_app/services/navigation_service.dart';
import 'package:firebase_filledstacks_app/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Post> _posts;
  List<Post> get posts => _posts;

  Future fetchPosts() async {
    setBusy(true);
    // TODO: Find or Create a TaskType that will automaticall do the setBusy(true/false) when being run.
    var postsResults = await _firestoreService.getPostsOnceOff();
    setBusy(false);

    if (postsResults is List<Post>) {
      _posts = postsResults;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Posts Update Failed',
        description: postsResults,
      );
    }
  }

  void editPost(int index) {
    _navigationService.navigateTo(CreatePostViewRoute, arguments: _posts[index]);
  }

  void listenToPosts() {
    setBusy(true);
    _firestoreService.listenToPostsRealTime().listen((postsData) {
      List<Post> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _posts = updatedPosts;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future deletePost(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the post?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deletePost(_posts[index].documentId);
      setBusy(false);
    }
  }

  Future navigateToCreateView() => _navigationService.navigateTo(CreatePostViewRoute);
}
