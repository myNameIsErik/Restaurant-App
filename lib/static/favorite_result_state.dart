import 'package:restaurant_app/data/model/favorite_restaurant.dart';

sealed class FavoriteResultState {}

class FavoriteNoneState extends FavoriteResultState {}

class FavoriteLoadingState extends FavoriteResultState {}

class FavoriteErrorState extends FavoriteResultState {
  final String error;

  FavoriteErrorState(this.error);
}

class FavoriteLoadedState extends FavoriteResultState {
  final List<FavoriteRestaurant> data;

  FavoriteLoadedState(this.data);
}
