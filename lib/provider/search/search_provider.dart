import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(this._apiServices);

  // Menyimpan state pencarian
  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();
  RestaurantSearchResultState get resultState => _resultState;

  // Fungsi untuk melakukan pencarian restoran berdasarkan query
  Future<void> searchRestaurants(String query) async {
    if (query.isEmpty) {
      // Jika query kosong, hapus hasil pencarian dan tampilkan pesan
      clearSearchResults();
      return;
    }

    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _apiServices.searchRestaurant(query);
      if (result.error) {
        _resultState = RestaurantSearchErrorState("No restaurants found");
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
