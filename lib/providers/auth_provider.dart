import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  // 本地存储键名
  static const String _userKey = 'current_user';
  static const String _tokenKey = 'auth_token';

  // 初始化时检查本地存储
  Future<void> checkAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson != null) {
        _currentUser = User.fromJson(jsonDecode(userJson));
      }
    } catch (e) {
      debugPrint('检查登录状态失败：$e');
      _currentUser = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  // 登录（目前是 mock 实现，后续可替换为真实 API 调用）
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: 替换为真实的 API 调用
      // 模拟网络延迟
      await Future.delayed(const Duration(seconds: 1));

      // Mock 登录逻辑 - 简单验证
      if (email.isEmpty || password.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // 创建模拟用户
      _currentUser = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: email.split('@').first,
        email: email,
        avatarUrl: '',
      );

      // 保存到本地存储
      await _saveUserToPrefs();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('登录失败：$e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 注册（目前是 mock 实现，后续可替换为真实 API 调用）
  Future<bool> register(
    String name,
    String email,
    String password, {
    String? avatarUrl,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: 替换为真实的 API 调用
      // 模拟网络延迟
      await Future.delayed(const Duration(seconds: 1));

      // Mock 注册逻辑
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // 创建用户
      _currentUser = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        avatarUrl: avatarUrl ?? '',
      );

      // 保存到本地存储
      await _saveUserToPrefs();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('注册失败：$e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 登出
  Future<void> logout() async {
    _currentUser = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
      await prefs.remove(_tokenKey);
    } catch (e) {
      debugPrint('登出失败：$e');
    }
  }

  // 保存用户到本地存储
  Future<void> _saveUserToPrefs() async {
    if (_currentUser != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(_currentUser!.toJson()));
    }
  }
}
