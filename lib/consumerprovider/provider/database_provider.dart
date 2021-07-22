import 'package:filmax/consumerprovider/data/db/database_helper.dart';
import 'package:filmax/consumerprovider/data/model/tidakdigunakan/favorite.dart';
// import 'package:filmax/consumerprovider/data/model/restaurant.dart';
import 'package:filmax/consumerprovider/utils/result_state.dart';
import 'package:flutter/foundation.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}){
    _getFavorite();
  }

  ResultState? _state;
  ResultState? get state => _state;

  String _message = '';
  String get message => _message;

  List<Favorite> _restaurants = [];
  List<Favorite> get restaurants => _restaurants;

  void _getFavorite() async {
    _restaurants = await databaseHelper.getFavorite();
    if (_restaurants.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Favorite article) async {
    try {
      await databaseHelper.insertFavorite(article);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String url) async {
    try {
      await databaseHelper.removeFavorite(url);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}