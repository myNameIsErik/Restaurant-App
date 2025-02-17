import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screen/detail/favorite_icon_widget.dart';
import 'package:restaurant_app/screen/detail/menu_list.dart';
import 'package:restaurant_app/widgets/card/review/add_review_form.dart';
import 'package:restaurant_app/widgets/card/review/review_list.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/widgets/detail/view_more_detail.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  const BodyOfDetailScreenWidget({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: "image_${restaurant.id}",
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                restaurant.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              ChangeNotifierProvider(
                                create: (context) => FavoriteIconProvider(),
                                child: Consumer<RestaurantDetailProvider>(
                                    builder: (context, value, child) {
                                  return switch (value.resultState) {
                                    RestaurantDetailLoadedState(
                                      data: var restaurant
                                    ) =>
                                      FavoriteIconWidget(
                                          favRestaurant: restaurant),
                                    _ => const SizedBox(),
                                  };
                                }),
                              ),
                            ],
                          ),
                          const SizedBox.square(dimension: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.pin_drop,
                                size: 15,
                              ),
                              const SizedBox.square(dimension: 4),
                              Text(
                                "${restaurant.address}, ${restaurant.city}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox.square(dimension: 4),
                                  Text(
                                    restaurant.rating.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox.square(dimension: 16),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox.square(dimension: 16),
                Text(
                  "Deskripsi",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox.square(dimension: 8),
                ExpandableDescription(description: restaurant.description),
                const SizedBox.square(dimension: 16),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox.square(dimension: 16),
                MenuList(restaurant: restaurant),
                SizedBox(
                  height: 16,
                ),
                Text("Review",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ReviewList(customerReviews: restaurant.customerReviews),
                const SizedBox(height: 16),
                Text(
                  "Tambahkan review anda",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                AddReviewForm(restaurantId: restaurant.id)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
