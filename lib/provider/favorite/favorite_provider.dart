import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/model/favorite_restaurant.dart';
import 'package:restaurant_app/services/favorite_service.dart';
import 'package:restaurant_app/static/favorite_result_state.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteService dbHelper = FavoriteService();

  FavoriteResultState _state = FavoriteNoneState();
  FavoriteResultState get state => _state;

  List<FavoriteRestaurant> _favorites = [];
  List<FavoriteRestaurant> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _state = FavoriteLoadingState();
    notifyListeners();
    try {
      _favorites = await dbHelper.getFavorites();
      _state = FavoriteLoadedState(_favorites);
    } catch (e) {
      _state = FavoriteErrorState(e.toString());
    }
    notifyListeners();
  }

  Future<void> addFavorite(FavoriteRestaurant restaurant) async {
    try {
      await dbHelper.insertFavorite(restaurant);
      await loadFavorites();
    } catch (e) {
      _state = FavoriteErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await dbHelper.deleteFavorite(id);
      await loadFavorites();
    } catch (e) {
      _state = FavoriteErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    return await dbHelper.isFavorite(id);
  }
}
