import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.example.com';

  // Fetch data from a simulated API
  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return {'data': 'Simulated response from $endpoint'};
  }

  // Get collections from the API
  Future<List<String>> getCollections() async {
    final response = await fetchData('/collections');
    if (response['data'] != null) {
      return List.generate(1000, (index) => 'Collection $index');
    } else {
      throw Exception('Failed to load collections');
    }
  }

  // Get history items from the API
  Future<List<String>> getHistory() async {
    final response = await fetchData('/history');
    if (response['data'] != null) {
      return List.generate(500, (index) => 'History Item $index');
    } else {
      throw Exception('Failed to load history');
    }
  }

  // Mock POST request to simulate adding a collection
  Future<void> addCollection(String collectionName) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return;
  }

  // Mock PUT request to simulate updating a collection
  Future<void> updateCollection(int id, String newName) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return;
  }

  // Mock DELETE request to simulate deleting a collection
  Future<void> deleteCollection(int id) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return;
  }

  // Simulate user login
  Future<void> loginUser(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    if (username != 'user' || password != 'password') {
      throw Exception('Invalid credentials');
    }
    return;
  }
}
