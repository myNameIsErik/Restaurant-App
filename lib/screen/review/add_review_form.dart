import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      _nameController.clear();
      _reviewController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Review added successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant),
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
            Text(
              "Review",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant),
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
                onPressed: _submitReview,
                child: Text(
                  "Kirim",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
