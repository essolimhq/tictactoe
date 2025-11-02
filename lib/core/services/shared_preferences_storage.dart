import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/core/services/abstracts/storage.dart';

class SharedPreferencesStorage implements Storage {
  SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    final prefs = _prefs;
    if (prefs != null) return prefs;

    final instance = await SharedPreferences.getInstance();
    _prefs = instance;

    return instance;
  }

  @override
  Future<void> write<T>(String key, T value) async {
    final prefs = await _getPrefs();
    final jsonString = jsonEncode(value);
    await prefs.setString(key, jsonString);
  }

  @override
  Future<Map<String, dynamic>?> read(String key) async {
    final prefs = await _getPrefs();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;

    final decoded = jsonDecode(jsonString);

    return decoded as Map<String, dynamic>;
  }

  @override
  Future<void> delete(String key) async {
    final prefs = await _getPrefs();
    await prefs.remove(key);
  }

  @override
  Future<bool> exists(String key) async {
    final prefs = await _getPrefs();

    return prefs.containsKey(key);
  }

  @override
  Future<void> close() async {
    _prefs = null;
  }
}
