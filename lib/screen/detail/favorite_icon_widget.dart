import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/favorite_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final Restaurant favRestaurant;
  const FavoriteIconWidget({
    super.key,
    required this.favRestaurant,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final favoriteListProvider = context.read<FavoriteProvider>();
      final favoriteIconProvider = context.read<FavoriteIconProvider>();

      // Cek apakah restoran ini ada di daftar favorit
      final isFavorited =
          await favoriteListProvider.isFavorite(widget.favRestaurant.id);
      favoriteIconProvider.isFavorited = isFavorited;
      context.read<FavoriteProvider>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteIconProvider = context.watch<FavoriteIconProvider>();

    return IconButton(
      onPressed: () async {
        final isFavorited = favoriteIconProvider.isFavorited;

        final favoriteRestaurant = FavoriteRestaurant(
          id: widget.favRestaurant.id,
          name: widget.favRestaurant.name,
          city: widget.favRestaurant.city,
          address: widget.favRestaurant.address,
          pictureId: widget.favRestaurant.pictureId,
          rating: widget.favRestaurant.rating,
        );

        if (isFavorited) {
          context
              .read<FavoriteProvider>()
              .removeFavorite(widget.favRestaurant.id);
        } else {
          context.read<FavoriteProvider>().addFavorite(favoriteRestaurant);
        }
        favoriteIconProvider.isFavorited = !isFavorited;
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorited
            ? Icons.favorite
            : Icons.favorite_outline,
        color: Colors.pink,
      ),
    );
  }
}
