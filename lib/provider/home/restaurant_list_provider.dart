import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantListProvider(this._apiServices);

  RestaurantListResultState _resultState = RestaurantListNoneState();
  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    _resultState = RestaurantListLoadingState();
    notifyListeners();

    try {
      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
      }
    } catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
    }

    notifyListeners();
  }

  void setTestState(RestaurantListResultState state) {
    _resultState = state;
    notifyListeners();
  }
}
