import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(this._apiServices);

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();
  RestaurantSearchResultState get resultState => _resultState;

  Future<void> searchRestaurants(String query) async {
    if (query.isEmpty) {
      clearSearchResults();
      return;
    }

    _resultState = RestaurantSearchLoadingState();
    notifyListeners();

    try {
      final result = await _apiServices.searchRestaurant(query);
      if (result.error || result.restaurants.isEmpty) {
        _resultState = RestaurantSearchEmptyState();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
      }
    } catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
    }

    notifyListeners();
  }

  // Fungsi untuk membersihkan hasil pencarian
  void clearSearchResults() {
    _resultState = RestaurantSearchNoneState();
    notifyListeners();
  }
}
