import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/course.dart';
import '../data/mock_data.dart';

class UserProvider with ChangeNotifier {
  // User Profile
  String _userName = "User";
  String _userEmail = "";
  bool _isLoggedIn = false;
  bool _isAuthLoading = true; // New loading state

  // Learning Progress
  // Map of CourseID -> Progress (0.0 to 1.0)
  Map<String, double> _courseProgress = {};

  // Getters
  String get userName => _userName;
  String get userEmail => _userEmail;
  bool get isLoggedIn => _isLoggedIn;
  bool get isAuthLoading => _isAuthLoading;
  
  // Get progress for a specific course (defaults to 0.0)
  double getProgress(String courseId) {
    return _courseProgress[courseId] ?? 0.0;
  }

  // Calculate total courses completed
  int get completedCoursesCount {
    return _courseProgress.values.where((p) => p >= 1.0).length;
  }

  UserProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load User
    _userName = prefs.getString('userName') ?? "Momentum User";
    _userEmail = prefs.getString('userEmail') ?? "";
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Load Progress
    // We store it as a JSON string: "{\"101\": 0.5, \"102\": 1.0}"
    String? progressString = prefs.getString('courseProgress');
    if (progressString != null) {
      Map<String, dynamic> decoded = json.decode(progressString);
      // Convert dynamic map to <String, double>
      _courseProgress = decoded.map((key, value) => MapEntry(key, (value as num).toDouble()));
    } else {
      // Initialize with mock data progress for demo purposes if empty
      _courseProgress = {
        '101': 0.3,
        '103': 0.7,
      };
    }
    
    _isAuthLoading = false;
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _userName);
    await prefs.setString('userEmail', _userEmail);
    await prefs.setBool('isLoggedIn', _isLoggedIn);
    await prefs.setString('courseProgress', json.encode(_courseProgress));
  }

  // Actions
  Future<void> login(String name, String email) async {
    _userName = name;
    _userEmail = email;
    _isLoggedIn = true;
    notifyListeners();
    await _saveData();
  }

  Future<void> logout() async {
    _userName = "User";
    _userEmail = "";
    _isLoggedIn = false;
    _courseProgress = {}; // Optional: duplicate clear or keep? Usually clear on logout
    notifyListeners();
    await _saveData();
  }

  Future<void> updateCourseProgress(String courseId, double progress) async {
    // Clamp between 0.0 and 1.0
    double newProgress = progress.clamp(0.0, 1.0);
    _courseProgress[courseId] = newProgress;
    notifyListeners();
    await _saveData();
  }

  Future<void> markCourseComplete(String courseId) async {
    await updateCourseProgress(courseId, 1.0);
  }
}
