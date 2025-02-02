import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/widgets/card/restaurant_card.dart';

class BodyOfSearchScreen extends StatelessWidget {
  const BodyOfSearchScreen({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          RestaurantCard(
            restaurant: restaurant,
            onTap: () {
              Navigator.pushNamed(
                context,
                NavigationRoute.detailRoute.name,
                arguments: restaurant.id,
              );
            },
          ),
        ],
      ),
    );
  }
}
