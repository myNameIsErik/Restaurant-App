import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class ReviewListCard extends StatelessWidget {
  final List<CustomerReview> reviews;

  const ReviewListCard({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Card(
            // color: Theme.of(context).colorScheme.onPrimary,
            elevation: 4.0, // Bayangan
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(8.0), // Sudut tumpul pada card
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Image.asset(
                          "assets/images/food.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            review.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                          ),
                          Text(
                            review.date,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox.square(dimension: 8),
                  Text(
                    review.review,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
