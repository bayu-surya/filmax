import 'package:filmax/consumerprovider/data/model/tidakdigunakan/detail_restaurant.dart' as detail;
import 'package:filmax/consumerprovider/data/model/tidakdigunakan/favorite.dart';
import 'package:filmax/consumerprovider/data/model/tidakdigunakan/restaurant.dart';
import 'package:filmax/consumerprovider/data/model/tidakdigunakan/search_restaurant.dart' as search;

class DataMapper {

  RestaurantElement restaurantToRestaurantElement(search.Restaurant data) {
    return RestaurantElement(
      id: data.id,
      name: data.name,
      description: data.description,
      pictureId: data.pictureId,
      city: data.city,
      rating: data.rating,
    );
  }
  Favorite restaurantToFavorite(search.Restaurant data) {
    return Favorite(
      id: data.id,
      name: data.name,
      description: data.description,
      pictureId: data.pictureId,
      city: data.city,
      rating: data.rating.toString(),
    );
  }
  Favorite restaurantElementToFavorite(RestaurantElement data) {
    return Favorite(
      id: data.id,
      name: data.name,
      description: data.description,
      pictureId: data.pictureId,
      city: data.city,
      rating: data.rating.toString(),
    );
  }
  Favorite restaurantDetailToFavorite(detail.Restaurant data) {
    return Favorite(
      id: data.id,
      name: data.name,
      description: data.description,
      pictureId: data.pictureId,
      city: data.city,
      rating: data.rating.toString(),
    );
  }
}