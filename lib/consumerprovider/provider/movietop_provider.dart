
import 'package:filmax/consumerprovider/data/api/api_service.dart';
import 'package:filmax/consumerprovider/data/model/movie_top.dart';
import 'package:filmax/consumerprovider/utils/result_state.dart';
import 'package:flutter/foundation.dart';

class MovieTopProvider extends ChangeNotifier {

  final ApiService apiService;

  MovieTopProvider({required this.apiService}) {
    _fetchAllArticle();
  }

  MovieTop? _movieTop;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  MovieTop? get result => _movieTop;

  ResultState? get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.getListMovieTop();
      if (data.results.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Tidak ada data list movie top rated';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _movieTop = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error,\ntidak ada data list movie top rated.';
    }
  }
}