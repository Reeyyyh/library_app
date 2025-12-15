import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}


import 'package:flutter/material.dart';

class CollectionController extends ChangeNotifier {
  List<String> _collections = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPage = 1;
  final int _itemsPerPage = 100;

  List<String> get collections => _collections;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Simulate loading paginated data (could be from an API)
  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate search functionality with delay and pagination
  void searchCollections(String query) {
    _collections = List.generate(1000, (index) => 'Collection $index')
        .where((collection) => collection.contains(query))
        .toList();
    notifyListeners();
  }

  // Load more collections (pagination)
  Future<void> loadMoreCollections() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      _collections.addAll(List.generate(_itemsPerPage, (index) => 'Collection ${_currentPage * _itemsPerPage + index}'));
      _currentPage++;
    } catch (error) {
      _errorMessage = 'Failed to load more collections';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Simulate updating a collection item
  Future<void> updateCollection(int index, String newName) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections[index] = newName;
    _isLoading = false;
    notifyListeners();
  }

  // Simulate deleting a collection item
  Future<void> deleteCollection(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _collections.removeAt(index);
    _isLoading = false;
    notifyListeners();
  }
}




