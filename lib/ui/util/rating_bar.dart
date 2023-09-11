import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class CustomRatingBar extends StatelessWidget {
  CustomRatingBar({super.key, required this.numberOfRating});
  double numberOfRating;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        itemPadding: EdgeInsets.symmetric(horizontal: 5),
        itemCount: 5,
        itemSize: 20,
        maxRating: 5.0,
        ignoreGestures: true,
        initialRating: numberOfRating,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemBuilder: (context, index) {
          return const Icon(
            Icons.star,
            color: Colors.yellow,
          );
        },
        onRatingUpdate: (value) {});
  }
}
