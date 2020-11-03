import 'dart:ui';

import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int ratings;

  const RatingStars({Key key, this.ratings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String stars = '';
    for (int i = 0; i < ratings; i++) {
      stars += '⭐';
    }
    return Text(
      stars,
      style: TextStyle(
        fontSize: 18.0,
        letterSpacing: 1.2,
      ),
    );
  }
}
