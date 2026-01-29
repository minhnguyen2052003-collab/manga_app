
import 'package:flutter_riverpod/legacy.dart';

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