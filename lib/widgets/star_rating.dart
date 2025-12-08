import 'package:flutter/material.dart';


class StarRating extends StatefulWidget{
  const StarRating({super.key, required this.size, required this.maxRating, required this.selectedColor, required this.unselectedColor});
  final int maxRating;
  final double size;
  final Color selectedColor;
  final Color unselectedColor;


  @override
  State<StarRating> createState() {
    return _StarRatingState();
  }
}

class _StarRatingState extends State<StarRating>{
  int currentRating = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxRating, (index) {
        final isSelected = index < currentRating;

        return IconButton(
          onPressed: () {
            setState(() {
              currentRating = index + 1;
            });
          },
          icon: Icon(
            isSelected ? Icons.star : Icons.star_border,
            size: widget.size,
            color: isSelected
                ? widget.selectedColor
                : widget.unselectedColor,
          ),
        );
      }),
    );
  }
}