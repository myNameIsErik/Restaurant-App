import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/favorite_list_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/widgets/card/restaurant_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite List"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<FavoriteListProvider>(
              builder: (context, value, child) {
                final favoriteList = value.favoriteList;
                return switch (favoriteList.isNotEmpty) {
                  true => ListView.builder(
                      itemCount: favoriteList.length,
                      itemBuilder: (context, index) {
                        final restaurant = favoriteList[index];

                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: RestaurantCard(
                              restaurant: restaurant,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  NavigationRoute.detailRoute.name,
                                  arguments: restaurant.id,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  _ => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Lottie.asset("assets/lottie/empty.json",
                                width: 200, height: 200, fit: BoxFit.cover),
                          ),
                          Text("No Favorite"),
                        ],
                      ),
                    ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
