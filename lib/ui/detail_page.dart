import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myrestaurant/common/styles.dart';
import 'package:myrestaurant/data/model/restaurant.dart';
import 'package:myrestaurant/provider/database_provider.dart';
import 'package:myrestaurant/ui/review_page.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';
  final Restaurant restaurant;

  const DetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.isFavorite(restaurant.id),
            builder: (context, snapshot) {
              var isFavorite = snapshot.data ?? false;

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: false,
                    expandedHeight: 200,
                    leadingWidth: 38,
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xBB04E6FF),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: restaurant.pictureId,
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'images/error_image.jpeg',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                restaurant.name,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Flexible(
                                child: isFavorite
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          provider
                                              .removeFavorite(restaurant.id);
                                          Fluttertoast.showToast(
                                            msg:
                                                "Restaurant removed from favorites",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.grey[600],
                                            timeInSecForIosWeb: 1,
                                          );
                                        },
                                      )
                                    : IconButton(
                                        icon: const Icon(
                                          Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          provider.addFavorite(restaurant);
                                          Fluttertoast.showToast(
                                            msg:
                                                "Restaurant added to favorites",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.grey[600],
                                            timeInSecForIosWeb: 1,
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.blueGrey,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.pin_drop,
                                color: Colors.red,
                                size: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "${restaurant.address}, ${restaurant.city}",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: restaurant.rating.toDouble(),
                                    itemSize: 20,
                                    itemBuilder: (context, index) {
                                      return const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      );
                                    },
                                  ),
                                  Text(
                                    " ${restaurant.rating.toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(fontSize: 15),
                                  ),
                                ],
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    width: 1.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: const EdgeInsets.all(6),
                                ),
                                child: Text(
                                  restaurant.customerReviews!.isEmpty
                                      ? "No review yet"
                                      : "${restaurant.customerReviews?.length.toString()} reviews",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(fontSize: 15),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ReviewPage.routeName,
                                      arguments: restaurant.id);
                                },
                              )
                            ],
                          ),
                          restaurant.categories!.isNotEmpty
                              ? RichText(
                                  text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(fontSize: 15),
                                      children: [
                                        const TextSpan(text: "Category: "),
                                        TextSpan(
                                          text: _restaurantCat(
                                              restaurant.categories!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ]),
                                )
                              : const Text(
                                  "Category: -",
                                ),
                          const Divider(
                            color: Colors.blueGrey,
                          ),
                          Text(
                            restaurant.description,
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: _buildFAB(context, restaurant),
    );
  }
}

String _restaurantCat(List<Category> categories) {
  String result = "";
  for (int i = 0; i < categories.length; i++) {
    i == categories.length - 1
        ? result += categories[i].name
        : result += "${categories[i].name}, ";
  }

  return result;
}

Widget _buildFAB(BuildContext context, Restaurant restaurant) {
  return FloatingActionButton(
    backgroundColor: secondaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Menu',
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontSize: 150, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    onPressed: () {
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 8),
                  child: Column(
                    children: [
                      Text(
                        'Our Menu',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(
                        indent: 50,
                        endIndent: 50,
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Foods',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontSize: 26),
                            ),
                            Text(
                              'Drinks',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontSize: 26),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Table(
                            children: _buldMenus(context, restaurant),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

List<TableRow> _buldMenus(BuildContext context, Restaurant restaurant) {
  List<TableRow> result = [];
  int foodsLen = restaurant.menus?.foods.length ?? 0;
  int drinksLen = restaurant.menus?.drinks.length ?? 0;

  for (int i = 0; i < (foodsLen > drinksLen ? foodsLen : drinksLen); i++) {
    result.add(
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1, bottom: 1, left: 25),
            child: Text(
              i < foodsLen
                  ? "${i + 1}. ${restaurant.menus!.foods[i].name}"
                  : "",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1, bottom: 1, left: 25),
            child: Text(
              i < drinksLen
                  ? "${i + 1}. ${restaurant.menus!.drinks[i].name}"
                  : "",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  return result;
}
