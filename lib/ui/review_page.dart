import 'package:flutter/material.dart';
import 'package:myrestaurant/data/api/api_service.dart';
import 'package:myrestaurant/data/model/restaurant.dart';
import 'package:myrestaurant/provider/preferences_provider.dart';
import 'package:myrestaurant/provider/restaurant_review_provider.dart';
import 'package:myrestaurant/utils/result_state.dart';
import 'package:myrestaurant/widgets/card_review.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  static const routeName = '/review';
  final String id;

  const ReviewPage({super.key, required this.id});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<CustomerReview> _custReviews = [];
  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restaurant Reviews',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: FutureBuilder(
        future: ApiService().detailRestaurant(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: Center(
                child: Text(
                  'Error Occured!\nCheck your internet connection and try again later!',
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            _custReviews = snapshot.data?.restaurants[0].customerReviews ?? [];

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _custReviews.length,
                      itemBuilder: (context, index) {
                        var review = _custReviews[index];
                        return CardReview(restaurantReview: review);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: reviewController,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 10.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "Add a review...",
                            hintStyle:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[800],
                                    ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                      Consumer<PreferencesProvider>(
                        builder: (context, provider, child) {
                          return ValueListenableBuilder<TextEditingValue>(
                            valueListenable: reviewController,
                            builder: (context, value, child) {
                              return IconButton(
                                icon: const Icon(Icons.send),
                                color: Theme.of(context).primaryColor,
                                padding: EdgeInsets.zero,
                                onPressed: value.text.isNotEmpty
                                    ? () async {
                                        RestaurantReview result =
                                            await ApiService().addReview(
                                          widget.id,
                                          provider.profileName,
                                          value.text,
                                        );

                                        setState(() {
                                          _custReviews = result.customerReviews;
                                        });
                                        reviewController.clear();
                                      }
                                    : null,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No review yet for this restaurant!'),
            );
          }
        },
      ),
    );
  }
}
