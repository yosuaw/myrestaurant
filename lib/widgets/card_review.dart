import 'package:flutter/material.dart';
import 'package:myrestaurant/data/model/restaurant.dart';

class CardReview extends StatelessWidget {
  final CustomerReview restaurantReview;

  const CardReview({super.key, required this.restaurantReview});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurantReview.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              restaurantReview.date,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: 10),
            ),
            const Divider(
              thickness: 1.2,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              restaurantReview.review,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
