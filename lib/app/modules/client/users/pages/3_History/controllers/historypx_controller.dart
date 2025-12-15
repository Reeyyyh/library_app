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
