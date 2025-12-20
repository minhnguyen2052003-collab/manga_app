import 'package:flutter/material.dart';

class FiveStarsWidget extends StatelessWidget {
  const FiveStarsWidget({super.key, required this.ratio});

  final double ratio;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate((ratio).toInt(), (index) {
          return Icon(Icons.star, size: 24, color: Colors.blue);
        }),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [Colors.blue, Colors.yellow],
              stops: [0.5, 0.5],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds);
          },
          child: Icon(Icons.star, size: 24, color: Colors.white),
        ),
        ...List.generate(
          (5 - ratio).toInt(),
          (index) => Icon(Icons.star, size: 24, color: Colors.yellow),
        ),
      ],
    );
  }
}
