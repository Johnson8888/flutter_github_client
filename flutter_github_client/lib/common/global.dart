import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_github_client/common/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../index.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  // 网络存取对象
  static NetCache netCache = NetCache();
  static List<MaterialColor> get themes => _themes;
  static bool isRelease => bool.fromEnvironment("dart.vm.product");
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch(e) {
        print(e);
      }
    }
    /// 如果没有缓存 需要直接读取
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 00;
    Git.init();
  }

  static saveProfile() => 
    _prefs.setString("profile", jsonEncode(profile.toJson()));
}
