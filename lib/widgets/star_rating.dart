import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/rating_provider.dart';


class StarRating extends ConsumerWidget{
  const StarRating({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = ref.watch(ratingProvider);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index +1;
        final isSelected = starIndex <= rating;
        return IconButton(
          onPressed: () {
            ref.read(ratingProvider.notifier).setRating(starIndex);
          },
          icon: Icon(
            isSelected ? Icons.star : Icons.star_border,
            size: 32,
            color: isSelected
                ? Colors.amber
                : Colors.grey,
          ),
        );
      }),
    );
  }
}