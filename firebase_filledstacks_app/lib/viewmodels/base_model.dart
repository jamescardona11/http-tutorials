import 'package:firebase_filledstacks_app/locator.dart';
import 'package:firebase_filledstacks_app/models/user_models.dart';
import 'package:firebase_filledstacks_app/services/authentication_service.dart';
import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;
}
