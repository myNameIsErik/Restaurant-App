import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/provider/detail/expandable_description_provider.dart';

class ExpandableDescription extends StatelessWidget {
  final String description;

  const ExpandableDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpandableDescriptionProvider(),
      child: Consumer<ExpandableDescriptionProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                maxLines: provider.isExpanded ? null : 3,
                overflow:
                    provider.isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: provider.toggleExpansion,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      provider.isExpanded
                          ? "Lihat lebih sedikit"
                          : "Lihat selengkapnya",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      provider.isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
