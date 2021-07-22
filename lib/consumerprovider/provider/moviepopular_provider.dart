
import 'package:filmax/consumerprovider/data/api/api_service.dart';
import 'package:filmax/consumerprovider/data/model/movie_popular.dart';
import 'package:filmax/consumerprovider/utils/result_state.dart';
import 'package:flutter/foundation.dart';

class MoviePopularProvider extends ChangeNotifier {

  final ApiService apiService;

  MoviePopularProvider({required this.apiService}) {
    _fetchAllArticle();
  }

  MoviePopular? _moviePopular;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  MoviePopular? get result => _moviePopular;

  ResultState? get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.getListMoviePopuler();
      if (data.results.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Tidak ada data list movie popular';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _moviePopular = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error,\ntidak ada data list movie popular.';
    }
  }
}