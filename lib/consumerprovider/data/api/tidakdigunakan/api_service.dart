import 'dart:convert';

import 'package:filmax/consumerprovider/data/model/tidakdigunakan/detail_restaurant.dart' as detail;
import 'package:filmax/consumerprovider/data/model/tidakdigunakan/restaurant.dart';
import 'package:filmax/consumerprovider/data/model/tidakdigunakan/search_restaurant.dart' as search;
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrlImage = 'https://restaurant-api.dicoding.dev/images/';
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<Restaurant> listRestaurant() async {
    var url = Uri.parse(_baseUrl +"list");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Restaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<detail.DetailRestaurant> detailRestaurant(String id) async {
    var url = Uri.parse(_baseUrl +"detail/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return detail.DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<search.SearchRestaurant> searchRestaurant(String query) async {
    var url = Uri.parse(_baseUrl +"search?q=$query");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return search.SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search restaurant');
    }
  }
}