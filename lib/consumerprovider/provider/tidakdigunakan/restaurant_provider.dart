
import 'package:filmax/consumerprovider/data/api/tidakdigunakan/api_service.dart';
import 'package:filmax/consumerprovider/data/model/tidakdigunakan/restaurant.dart';
import 'package:flutter/foundation.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {

  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllArticle();
  }

  Restaurant? _restaurantResult;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  Restaurant? get result => _restaurantResult;

  ResultState? get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.listRestaurant();
      if (data.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Tidak ada data list restaurant';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error,\ntidak ada data list restaurant.';
    }
  }
}