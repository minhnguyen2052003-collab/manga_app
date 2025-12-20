import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod/riverpod.dart';

class RatingNotifier extends StateNotifier<int> {
  RatingNotifier() : super(0);

  void setRating(int newRating) {
    state = newRating;
  }

  void reset() {
    state = 0;
  }
}

final ratingProvider = StateNotifierProvider<RatingNotifier, int>((ref) {
  return RatingNotifier();
});
