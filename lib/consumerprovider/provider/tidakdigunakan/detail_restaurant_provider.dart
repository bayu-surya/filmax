
import 'package:filmax/consumerprovider/data/api/tidakdigunakan/api_service.dart';
import 'package:filmax/consumerprovider/data/model/tidakdigunakan/detail_restaurant.dart';
import 'package:flutter/foundation.dart';

enum ResultState { Loading, NoData, HasData, Error }

class DetailRestaurantProvider extends ChangeNotifier {

  final ApiService apiService;

  DetailRestaurantProvider({required this.apiService});

  Restaurant? _restaurantResult;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  Restaurant? get result => _restaurantResult;

  ResultState? get state => _state;

  Future<dynamic> fetchAllArticle(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.detailRestaurant(id);
      if (data.restaurant==null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Tidak ada informasi detail restaurant';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = data.restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error,\ntidak ada informasi detail restaurant.';
    }
  }
}