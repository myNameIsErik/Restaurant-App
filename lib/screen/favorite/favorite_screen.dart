import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/widgets/card/favorite_restaurant_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<FavoriteProvider>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite List"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Consumer<FavoriteProvider>(
          builder: (context, value, child) {
            if (value.favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/lottie/empty.json",
                        width: 200, height: 200, fit: BoxFit.cover),
                    const SizedBox(height: 16),
                    Text("No Favorite"),
                  ],
                ),
              );
            }

            final favoriteList = value.favorites;
            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final favorite = favoriteList[index];
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: FavoriteRestaurantCard(
                    favRestaurant: favorite,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: favorite.id,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
