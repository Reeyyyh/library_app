import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  String _username = 'John Doe';
  String _email = 'john.doe@example.com';
  bool _isLoading = false;
  String _errorMessage = '';

  String get username => _username;
  String get email => _email;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate updating profile data
  Future<void> updateProfile(String newUsername, String newEmail) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      if (newUsername.isEmpty || newEmail.isEmpty) {
        throw 'Fields cannot be empty';
      }
      _username = newUsername;
      _email = newEmail;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate resetting password
  Future<void> resetPassword(String oldPassword, String newPassword) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      if (oldPassword != 'correctOldPassword') {
        throw 'Old password is incorrect';
      }
      if (newPassword.isEmpty) {
        throw 'New password cannot be empty';
      }
      _errorMessage = ''; // Clear previous error
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate deleting profile
  Future<void> deleteProfile() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3)); // Simulate network delay
    try {
      _username = '';
      _email = '';
    } catch (error) {
      _errorMessage = 'Failed to delete profile';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
