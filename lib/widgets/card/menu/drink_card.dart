import 'package:flutter/material.dart';

class DrinkCard extends StatelessWidget {
  final String name;

  const DrinkCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
                child: Image.asset(
                  "assets/images/drink.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox.square(dimension: 8),
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
