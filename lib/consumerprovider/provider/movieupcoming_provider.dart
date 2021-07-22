
import 'package:filmax/consumerprovider/data/api/api_service.dart';
import 'package:filmax/consumerprovider/data/model/movie_upcoming.dart';
import 'package:filmax/consumerprovider/utils/result_state.dart';
import 'package:flutter/foundation.dart';

class MovieUpcomingProvider extends ChangeNotifier {

  final ApiService apiService;

  MovieUpcomingProvider({required this.apiService}) {
    _fetchAllArticle();
  }

  MovieUpcoming? _movieUpcoming;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  MovieUpcoming? get result => _movieUpcoming;

  ResultState? get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.getListMovieUpcoming();
      if (data.results.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Tidak ada data list movie upcoming';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _movieUpcoming = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error,\ntidak ada data list movie upcoming.';
    }
  }
}