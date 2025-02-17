import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/model/favorite_restaurant.dart';
import 'package:restaurant_app/services/favorite_service.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteService dbHelper = FavoriteService();

  List<FavoriteRestaurant> _favorites = [];
  List<FavoriteRestaurant> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _favorites = await dbHelper.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(FavoriteRestaurant restaurant) async {
    await dbHelper.insertFavorite(restaurant);
    await loadFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await dbHelper.deleteFavorite(id);
    await loadFavorites();
  }

  Future<bool> isFavorite(String id) async {
    return await dbHelper.isFavorite(id);
  }
}
