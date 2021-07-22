
import 'package:filmax/consumerprovider/data/api/tidakdigunakan/api_service.dart';
import 'package:filmax/consumerprovider/data/model/tidakdigunakan/search_restaurant.dart';
import 'package:flutter/foundation.dart';

enum ResultState { Loading, NoData, HasData, Error, Empty }

class SearchRestaurantProvider extends ChangeNotifier {

  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService});

  SearchRestaurant? _restaurantResult;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  SearchRestaurant? get result => _restaurantResult;

  ResultState? get state => _state;

  Future<dynamic> fetchAllArticle(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.searchRestaurant(query);
      if (data.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Hasil pencarian tidak ditemukan,\nmohon ganti kata kunci pencarian.';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Proses pencarian mengalami error.';
    }
  }

  void empty() {
    _state = ResultState.Empty;
    notifyListeners();
  }
}