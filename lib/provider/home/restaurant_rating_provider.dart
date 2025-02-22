import 'package:flutter/widgets.dart';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class RestaurantRatingProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantRatingProvider(this._apiServices);

  RestaurantListResultState _resultState = RestaurantListNoneState();
  RestaurantListResultState get resultState => _resultState;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  Future<void> fetchRestaurantRating() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
      } else {
        _restaurants = result.restaurants;

        // Sorting data berdasarkan rating tertinggi ke terendah
        _restaurants.sort((a, b) => b.rating.compareTo(a.rating));

        _resultState = RestaurantListLoadedState(_restaurants);
      }
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }

  void setTestState(RestaurantListResultState state) {
    _resultState = state;
    notifyListeners();
  }
}
