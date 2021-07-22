import 'package:filmax/consumerprovider/data/preferences/preferences_helper.dart';
import 'package:flutter/foundation.dart';

class PreferencesProvider extends ChangeNotifier {

  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}){
    _getNotification();
  }

  bool _isNotification = false;
  bool get isNotification => _isNotification;

  void _getNotification() async {
    _isNotification = await preferencesHelper.isNotification;
    notifyListeners();
  }

  void enableNotification(bool value) {
    preferencesHelper.setNotification(value);
    _getNotification();
  }
}