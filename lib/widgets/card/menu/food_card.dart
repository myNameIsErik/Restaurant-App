import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;

  const FoodCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      shadowColor: Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 100,
                  minHeight: 100,
                  maxWidth: 100,
                  minWidth: 100,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.asset(
                    "assets/images/food.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox.square(dimension: 8),
            Expanded(
              child: Text(
                name,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
