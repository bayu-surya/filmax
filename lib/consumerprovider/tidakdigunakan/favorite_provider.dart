import 'package:filmax/consumerprovider/data/model/tidakdigunakan/restaurant.dart';
import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<RestaurantElement> _favoriteList = [];

  List<RestaurantElement> get favoriteList => _favoriteList;

  List<String> favoriteIndex() {
    List<String> data = [];
    for(int i=0;i<_favoriteList.length;i++){
      data.add(_favoriteList[i].id);
    }
    return data;
  }

  void complete(RestaurantElement moduleName) {
    _favoriteList.add(moduleName);
    notifyListeners();
  }

  void remove(RestaurantElement moduleName) {
    _favoriteList.removeWhere((item) => item.id ==moduleName.id);
    notifyListeners();
  }
}