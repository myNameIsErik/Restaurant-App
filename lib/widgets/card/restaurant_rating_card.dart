import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantRatingCard extends StatelessWidget {
  final Restaurant restaurantRating;
  final Function() onTap;

  const RestaurantRatingCard({
    super.key,
    required this.restaurantRating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        // color: Theme.of(context).colorScheme.onPrimary,
        elevation: 4.0, // Bayangan
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Sudut tumpul pada card
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 100,
                      minHeight: 100,
                      maxWidth: 100,
                      minWidth: 100,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/small/${restaurantRating.pictureId}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox.square(dimension: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          restaurantRating.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox.square(dimension: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.pin_drop,
                              size: 15,
                            ),
                            const SizedBox.square(dimension: 4),
                            Expanded(
                              child: Text(
                                restaurantRating.city,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox.square(dimension: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.orange,
                            ),
                            const SizedBox.square(dimension: 4),
                            Expanded(
                              child: Text(
                                restaurantRating.rating.toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9), // Jarak antara Row dan Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi saat tombol ditekan
                    // Navigator.pushNamed(
                    //   context,
                    //   NavigationRoute.detailRoute.name,
                    //   arguments: restaurantRating.id,
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Theme.of(context).colorScheme.primary,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Lihat Detail",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        // color: Theme.of(context).colorScheme.onPrimary,
                        size: 13,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
