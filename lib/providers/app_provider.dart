// lib/providers/app_provider.dart
// =========================================================================
// File: app_provider.dart / theme_provider.dart
// Domain: State Management & Business Logic Layer
// Description: Manages application reactive states, theme data dynamic updates, 
//              and decouples front-end widgets from backend logic operations.
// Architecture: Clean State Management (Provider/Riverpod)
// =========================================================================

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/problem_model.dart';

class AppProvider extends ChangeNotifier {
  // ─── Keys ──────────────────────────────────────────────────────────────────
  static const String _favoritesKey = 'favorites_ids';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _hasSeenOnboardingKey = 'has_seen_onboarding';
  static const String _totalSolvedKey = 'total_solved';
  static const String _totalViewedKey = 'total_viewed';

  // ─── State ─────────────────────────────────────────────────────────────────
  List<ProblemCategory> _categories = [];
  List<Problem> _allProblems = [];
  List<Problem> _favoriteProblems = [];
  List<Problem> _searchResults = [];
  String _searchQuery = '';
  bool _isSearching = false;
  bool _isLoading = true;
  bool _isLoggedIn = false;
  bool _hasSeenOnboarding = false;
  String _userName = '';
  String _userEmail = '';
  int _totalSolved = 0;
  int _totalViewed = 0;

  // ─── Getters ───────────────────────────────────────────────────────────────
  List<ProblemCategory> get categories => _categories;
  List<Problem> get allProblems => _allProblems;
  List<Problem> get favoriteProblems => _favoriteProblems;
  List<Problem> get searchResults => _searchResults;
  String get searchQuery => _searchQuery;
  bool get isSearching => _isSearching;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  bool get hasSeenOnboarding => _hasSeenOnboarding;
  String get userName => _userName;
  String get userEmail => _userEmail;
  int get totalSolved => _totalSolved;
  int get totalViewed => _totalViewed;
  int get favoritesCount => _favoriteProblems.length;

  // ─── Init ──────────────────────────────────────────────────────────────────
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    // Load mock categories
    _categories = List.from(mockCategories);
    _allProblems = getAllProblems();

    // Load persisted data
    await _loadFromPrefs();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      _isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
      _hasSeenOnboarding = prefs.getBool(_hasSeenOnboardingKey) ?? false;
      _userName = prefs.getString(_userNameKey) ?? '';
      _userEmail = prefs.getString(_userEmailKey) ?? '';
      _totalSolved = prefs.getInt(_totalSolvedKey) ?? 0;
      _totalViewed = prefs.getInt(_totalViewedKey) ?? 0;

      // Load favorite IDs and map to problems
      final favoriteIds = prefs.getStringList(_favoritesKey) ?? [];
      _favoriteProblems = _allProblems
          .where((p) => favoriteIds.contains(p.id))
          .map((p) => p.copyWith(isFavorite: true))
          .toList();

      // Mark favorites in allProblems
      for (var problem in _allProblems) {
        problem.isFavorite = favoriteIds.contains(problem.id);
      }
      // Also mark in categories
      for (var cat in _categories) {
        for (var problem in cat.problems) {
          problem.isFavorite = favoriteIds.contains(problem.id);
        }
      }
    } catch (_) {
      // Silently fail — defaults are fine
    }
  }

  // ─── Session ───────────────────────────────────────────────────────────────
  Future<void> login(String name, String email) async {
    _isLoggedIn = true;
    _userName = name;
    _userEmail = email;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userNameKey, name);
      await prefs.setString(_userEmailKey, email);
    } catch (_) {}
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, false);
    } catch (_) {}
  }

  Future<void> setOnboardingSeen() async {
    _hasSeenOnboarding = true;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_hasSeenOnboardingKey, true);
    } catch (_) {}
  }

  // ─── Favorites ─────────────────────────────────────────────────────────────
  Future<void> toggleFavorite(Problem problem) async {
    final existingIndex = _favoriteProblems.indexWhere((p) => p.id == problem.id);

    if (existingIndex >= 0) {
      // Remove from favorites
      _favoriteProblems.removeAt(existingIndex);
      problem.isFavorite = false;
      // Update in allProblems
      final idx = _allProblems.indexWhere((p) => p.id == problem.id);
      if (idx >= 0) _allProblems[idx].isFavorite = false;
      // Update in categories
      for (var cat in _categories) {
        final cidx = cat.problems.indexWhere((p) => p.id == problem.id);
        if (cidx >= 0) cat.problems[cidx].isFavorite = false;
      }
    } else {
      // Add to favorites
      final favProblem = problem.copyWith(isFavorite: true);
      _favoriteProblems.add(favProblem);
      problem.isFavorite = true;
      // Update in allProblems
      final idx = _allProblems.indexWhere((p) => p.id == problem.id);
      if (idx >= 0) _allProblems[idx].isFavorite = true;
      // Update in categories
      for (var cat in _categories) {
        final cidx = cat.problems.indexWhere((p) => p.id == problem.id);
        if (cidx >= 0) cat.problems[cidx].isFavorite = true;
      }
      _totalSolved++;
      await _saveSolvedCount();
    }

    await _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(String problemId) {
    return _favoriteProblems.any((p) => p.id == problemId);
  }

  Future<void> removeFavorite(String problemId) async {
    _favoriteProblems.removeWhere((p) => p.id == problemId);
    final idx = _allProblems.indexWhere((p) => p.id == problemId);
    if (idx >= 0) _allProblems[idx].isFavorite = false;
    for (var cat in _categories) {
      final cidx = cat.problems.indexWhere((p) => p.id == problemId);
      if (cidx >= 0) cat.problems[cidx].isFavorite = false;
    }
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ids = _favoriteProblems.map((p) => p.id).toList();
      await prefs.setStringList(_favoritesKey, ids);
    } catch (_) {}
  }

  // ─── Search ────────────────────────────────────────────────────────────────
  void search(String query) {
    _searchQuery = query.trim();
    _isSearching = query.isNotEmpty;
    if (_searchQuery.isEmpty) {
      _searchResults = [];
    } else {
      final q = _searchQuery.toLowerCase();
      _searchResults = _allProblems.where((problem) {
        return problem.title.toLowerCase().contains(q) ||
            problem.categoryTitle.toLowerCase().contains(q) ||
            problem.shortDescription.toLowerCase().contains(q) ||
            problem.fullDescription.toLowerCase().contains(q);
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _isSearching = false;
    _searchResults = [];
    notifyListeners();
  }

  // ─── Stats ─────────────────────────────────────────────────────────────────
  Future<void> incrementViewed() async {
    _totalViewed++;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_totalViewedKey, _totalViewed);
    } catch (_) {}
  }

  Future<void> _saveSolvedCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_totalSolvedKey, _totalSolved);
    } catch (_) {}
  }

  // ─── Get problems by category ───────────────────────────────────────────────
  List<Problem> getProblemsByCategory(String categoryId) {
    return _allProblems.where((p) => p.categoryId == categoryId).toList();
  }

  ProblemCategory? getCategoryById(String id) {
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}
