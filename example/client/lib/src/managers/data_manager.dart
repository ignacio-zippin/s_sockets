// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../enums/culture.dart';
import '../support/network/network.dart';

class DataManager {
  static final DataManager _instance = DataManager._constructor();
  SharedPreferences? prefs;

  factory DataManager() {
    return _instance;
  }

  DataManager._constructor();

  init() async {
    //_dataAccess = RemoteDataAccess();
    // _dataAccess = DummyDataAccess();

    prefs = await SharedPreferences.getInstance();
  }

  //#region Preferences
  hasSession() {
    return prefs?.getString('token') != null;
  }

  saveToken(String token) async {
    try {
      await prefs?.setString('token', token);
      Network().setToken(token);
    } catch (e) {
      throw Exception(e);
    }
  }

  saveCulture(Culture culture) async {
    try {
      await prefs?.setString('culture', jsonEncode(culture.toString()));
    } catch (e) {
      throw Exception(e);
    }
  }

  getCulture() {
    try {
      if (jsonDecode(prefs?.getString('culture') ?? '') == "Culture.es") {
        return Culture.es;
      } else {
        return Culture.en;
      }
    } catch (e) {
      return Culture.es;
    }
  }

  void cleanData() async {
    Network().token = null;
    prefs?.remove("token");
  }

  //#endregion
}
