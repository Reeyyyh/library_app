import 'package:flutter/material.dart';

class HistoryController extends ChangeNotifier {
  List<String> _history = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 50;

  List<String> get history => _history;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated history data
  Future<void> loadHistory() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _history.addAll(List.generate(_itemsPerPage,
          (index) => 'History Item ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load history';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate filtering history
  void filterHistory(String query) {
    _history = List.generate(500, (index) => 'History Item $index')
        .where((item) => item.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more history items (pagination)
  Future<void> loadMoreHistory() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _history.addAll(List.generate(_itemsPerPage,
          (index) => 'History Item ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more history';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate deleting history item
  Future<void> deleteHistory(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _history.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  String _username = 'John Doe';
  String _email = 'john.doe@example.com';
  bool _isLoading = false;
  String _errorMessage = '';
  String _phoneNumber = '123-456-7890';
  String _address = '123 Main Street, Springfield, USA';
  bool _isSubscribed = false;

  String get username => _username;
  String get email => _email;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get phoneNumber => _phoneNumber;
  String get address => _address;
  bool get isSubscribed => _isSubscribed;

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

  // Simulate updating phone number
  Future<void> updatePhoneNumber(String newPhoneNumber) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (newPhoneNumber.isEmpty) {
        throw 'Phone number cannot be empty';
      }
      _phoneNumber = newPhoneNumber;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating address
  Future<void> updateAddress(String newAddress) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (newAddress.isEmpty) {
        throw 'Address cannot be empty';
      }
      _address = newAddress;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate subscribing to a newsletter
  Future<void> subscribeToNewsletter() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (_isSubscribed) {
        throw 'Already subscribed';
      }
      _isSubscribed = true;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate unsubscribing from the newsletter
  Future<void> unsubscribeFromNewsletter() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (!_isSubscribed) {
        throw 'Not subscribed';
      }
      _isSubscribed = false;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate password recovery
  Future<void> recoverPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      if (email.isEmpty || !email.contains('@')) {
        throw 'Invalid email address';
      }
      _errorMessage = 'A recovery link has been sent to $email'; // Simulate sending an email
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate saving user preferences
  Future<void> savePreferences(Map<String, dynamic> preferences) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      // Simulate saving preferences to a database or remote service
      _errorMessage = 'Preferences saved successfully';
    } catch (error) {
      _errorMessage = 'Failed to save preferences';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate loading user preferences
  Future<void> loadPreferences() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      // Simulate loading preferences from a database or remote service
      _errorMessage = 'Preferences loaded successfully';
    } catch (error) {
      _errorMessage = 'Failed to load preferences';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate logging out
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      // Simulate logging out process
      _username = '';
      _email = '';
      _phoneNumber = '';
      _address = '';
      _isSubscribed = false;
      _errorMessage = 'Logged out successfully';
    } catch (error) {
      _errorMessage = 'Failed to log out';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  String _username = 'John Doe';
  String _email = 'john.doe@example.com';
  bool _isLoading = false;
  String _errorMessage = '';
  String _phoneNumber = '123-456-7890';
  String _address = '123 Main Street, Springfield, USA';
  bool _isSubscribed = false;

  String get username => _username;
  String get email => _email;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get phoneNumber => _phoneNumber;
  String get address => _address;
  bool get isSubscribed => _isSubscribed;

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

  // Simulate updating phone number
  Future<void> updatePhoneNumber(String newPhoneNumber) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (newPhoneNumber.isEmpty) {
        throw 'Phone number cannot be empty';
      }
      _phoneNumber = newPhoneNumber;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating address
  Future<void> updateAddress(String newAddress) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (newAddress.isEmpty) {
        throw 'Address cannot be empty';
      }
      _address = newAddress;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate subscribing to a newsletter
  Future<void> subscribeToNewsletter() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (_isSubscribed) {
        throw 'Already subscribed';
      }
      _isSubscribed = true;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate unsubscribing from the newsletter
  Future<void> unsubscribeFromNewsletter() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (!_isSubscribed) {
        throw 'Not subscribed';
      }
      _isSubscribed = false;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate password recovery
  Future<void> recoverPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      if (email.isEmpty || !email.contains('@')) {
        throw 'Invalid email address';
      }
      _errorMessage = 'A recovery link has been sent to $email'; // Simulate sending an email
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate saving user preferences
  Future<void> savePreferences(Map<String, dynamic> preferences) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      // Simulate saving preferences to a database or remote service
      _errorMessage = 'Preferences saved successfully';
    } catch (error) {
      _errorMessage = 'Failed to save preferences';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate loading user preferences
  Future<void> loadPreferences() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      // Simulate loading preferences from a database or remote service
      _errorMessage = 'Preferences loaded successfully';
    } catch (error) {
      _errorMessage = 'Failed to load preferences';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate logging out
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      // Simulate logging out process
      _username = '';
      _email = '';
      _phoneNumber = '';
      _address = '';
      _isSubscribed = false;
      _errorMessage = 'Logged out successfully';
    } catch (error) {
      _errorMessage = 'Failed to log out';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  String _username = 'John Doe';
  String _email = 'john.doe@example.com';
  bool _isLoading = false;
  String _errorMessage = '';
  String _phoneNumber = '123-456-7890';
  String _address = '123 Main Street, Springfield, USA';
  bool _isSubscribed = false;

  String get username => _username;
  String get email => _email;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get phoneNumber => _phoneNumber;
  String get address => _address;
  bool get isSubscribed => _isSubscribed;

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

  // Simulate updating phone number
  Future<void> updatePhoneNumber(String newPhoneNumber) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (newPhoneNumber.isEmpty) {
        throw 'Phone number cannot be empty';
      }
      _phoneNumber = newPhoneNumber;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating address
  Future<void> updateAddress(String newAddress) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (newAddress.isEmpty) {
        throw 'Address cannot be empty';
      }
      _address = newAddress;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate subscribing to a newsletter
  Future<void> subscribeToNewsletter() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (_isSubscribed) {
        throw 'Already subscribed';
      }
      _isSubscribed = true;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate unsubscribing from the newsletter
  Future<void> unsubscribeFromNewsletter() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      if (!_isSubscribed) {
        throw 'Not subscribed';
      }
      _isSubscribed = false;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate password recovery
  Future<void> recoverPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      if (email.isEmpty || !email.contains('@')) {
        throw 'Invalid email address';
      }
      _errorMessage = 'A recovery link has been sent to $email'; // Simulate sending an email
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate saving user preferences
  Future<void> savePreferences(Map<String, dynamic> preferences) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      // Simulate saving preferences to a database or remote service
      _errorMessage = 'Preferences saved successfully';
    } catch (error) {
      _errorMessage = 'Failed to save preferences';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate loading user preferences
  Future<void> loadPreferences() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      // Simulate loading preferences from a database or remote service
      _errorMessage = 'Preferences loaded successfully';
    } catch (error) {
      _errorMessage = 'Failed to load preferences';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate logging out
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    try {
      // Simulate logging out process
      _username = '';
      _email = '';
      _phoneNumber = '';
      _address = '';
      _isSubscribed = false;
      _errorMessage = 'Logged out successfully';
    } catch (error) {
      _errorMessage = 'Failed to log out';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
