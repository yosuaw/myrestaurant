import 'package:flutter/material.dart';
import 'package:myrestaurant/data/model/restaurant.dart';
import 'package:myrestaurant/ui/detail_page.dart';

class ListPage extends StatelessWidget {
  static const routeName = '/list';
  final List<Restaurant> restaurants;

  const ListPage({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Restaurant",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _welcomeText(context),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'What do you want to eat today?',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: restaurants.length,
                itemBuilder: (context, idx) {
                  return _buildRestaurantItem(context, restaurants[idx]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _welcomeText(BuildContext context) {
  int hour = DateTime.now().toLocal().hour;
  String text = '';

  if (hour >= 1 && hour < 12) {
    text = "Good Morning";
  } else if (hour >= 12 && hour < 15) {
    text = "Good Afternoon";
  } else if (hour >= 15 && hour < 19) {
    text = "Good Evening";
  } else if (hour >= 19 && hour <= 24) {
    text = "Good Night";
  }

  return Text(
    text += ' 🍱',
    style: Theme.of(context).textTheme.titleMedium,
  );
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return Material(
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, DetailPage.routeName,
                arguments: restaurant);
          },
          behavior: HitTestBehavior.opaque,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: Image.network(
                        restaurant.pictureId,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'images/error_image.jpeg',
                            fit: BoxFit.cover,
                            height: 200,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              size: 15.0,
                              color: Colors.red,
                            ),
                            Text(
                              restaurant.city,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rate,
                              size: 15.0,
                              color: Colors.yellow,
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
