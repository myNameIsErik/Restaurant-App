import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/review/add_review_provider.dart';

class AddReviewForm extends StatefulWidget {
  final String restaurantId;

  const AddReviewForm({super.key, required this.restaurantId});

  @override
  State<AddReviewForm> createState() => _AddReviewFormState();
}

class _AddReviewFormState extends State<AddReviewForm> {
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  void _submitReview() {
    final provider = context.read<AddReviewProvider>();
    final id = widget.restaurantId;
    final name = _nameController.text.trim();
    final review = _reviewController.text.trim();

    if (name.isNotEmpty && review.isNotEmpty) {
      provider.addReview(id, name, review);
      context.read<RestaurantDetailProvider>().fetchRestaurantDetail(id);
      _nameController.clear();
      _reviewController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Review berhasil ditambahkan!",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Isi nama dan review terlebih dahulu!",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onError,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      shadowColor: Theme.of(context).colorScheme.onSurface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama", style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Masukkan nama',
                  hintStyle: Theme.of(context).textTheme.labelLarge,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text("Review", style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: TextField(
                controller: _reviewController,
                decoration: InputDecoration(
                  hintText: 'Masukkan review',
                  hintStyle: Theme.of(context).textTheme.labelLarge,
                  border: InputBorder.none,
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _submitReview,
                child: Text(
                  "Kirim",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
