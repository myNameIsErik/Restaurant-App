import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/screen/detail/menu_list.dart';
import 'package:restaurant_app/screen/review/add_review_form.dart';
import 'package:restaurant_app/screen/review/review_list.dart';

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
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0),
            ),
            child: Image.network(
              "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
              fit: BoxFit.cover,
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
                          Text(
                            restaurant.name,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox.square(dimension: 8),
                          Text(
                            "${restaurant.address}, ${restaurant.city}",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        const SizedBox.square(dimension: 4),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox.square(dimension: 16),
                Divider(
                  thickness: 1, // Ketebalan garis
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.3), // Jarak dari kanan
                ),
                Text(
                  "Kategori",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox.square(dimension: 8),
                Wrap(
                  spacing: 8, // Jarak antar tag
                  children: restaurant.categories.map((category) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2), // Warna latar dari tema
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category.name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    );
                  }).toList(),
                ),
                Divider(
                  thickness: 1, // Ketebalan garis
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.3), // Jarak dari kanan
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
                Text(
                  restaurant.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox.square(dimension: 16),
                Divider(
                  thickness: 1, // Ketebalan garis
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.3), // Jarak dari kanan
                ),
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
                const SizedBox(height: 8),
                Text(
                  "Tambahkan review anda",
                  style: Theme.of(context).textTheme.bodyLarge,
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
