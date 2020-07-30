import 'package:firebase_filledstacks_app/constants/route_names.dart';
import 'package:firebase_filledstacks_app/locator.dart';
import 'package:firebase_filledstacks_app/services/authentication_service.dart';
import 'package:firebase_filledstacks_app/services/dialog_service.dart';
import 'package:firebase_filledstacks_app/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _selectedRole = 'Select a User Role';
  String get selectedRole => _selectedRole;

  Future signUp({@required String email, @required String password, @required String fullName}) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
      role: _selectedRole,
    );

    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign up failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign up Failure',
        description: result,
      );
    }
  }

  void setSelectedRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
}
