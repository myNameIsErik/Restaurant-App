import 'package:flutter/material.dart';

import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widgets/card/menu/drink_card.dart';
import 'package:restaurant_app/widgets/card/menu/food_card.dart';

class MenuList extends StatelessWidget {
  final Restaurant restaurant;

  const MenuList({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Menu",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox.square(dimension: 8),
        Text("Makanan", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox.square(dimension: 8),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: restaurant.menus.foods.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.height * 0.2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FoodCard(name: restaurant.menus.foods[index].name),
                ),
              );
            },
          ),
        ),
        const SizedBox.square(dimension: 16),
        Text("Minuman", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox.square(dimension: 8),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.22,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: restaurant.menus.drinks.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.height * 0.2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: DrinkCard(name: restaurant.menus.drinks[index].name),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
