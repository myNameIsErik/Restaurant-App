import 'package:restaurant_app/data/model/restaurant.dart';

sealed class RestaurantSearchResultState {}

class RestaurantSearchNoneState extends RestaurantSearchResultState {
  RestaurantSearchNoneState();
}

class RestaurantSearchLoadingState extends RestaurantSearchResultState {
  RestaurantSearchLoadingState();
}

class RestaurantSearchErrorState extends RestaurantSearchResultState {
  final String error;

  RestaurantSearchErrorState(this.error);
}

class RestaurantSearchLoadedState extends RestaurantSearchResultState {
  final List<Restaurant> data;

  RestaurantSearchLoadedState(this.data);
}

class RestaurantSearchEmptyState extends RestaurantSearchResultState {
  RestaurantSearchEmptyState();
}
