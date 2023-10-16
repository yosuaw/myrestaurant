import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myrestaurant/common/styles.dart';
import 'package:myrestaurant/data/model/restaurant.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';
  final Restaurant restaurant;

  const DetailPage({super.key, required this.restaurant});

  List<TableRow> _buldMenus(BuildContext context) {
    List<TableRow> result = [];
    int foodsLen = restaurant.menus['foods'].length;
    int drinksLen = restaurant.menus['drinks'].length;

    for (int i = 0; i < (foodsLen > drinksLen ? foodsLen : drinksLen); i++) {
      result.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1, bottom: 1, left: 25),
              child: Text(
                i < foodsLen
                    ? "${i + 1}. ${restaurant.menus['foods'][i]['name']}"
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
                    ? "${i + 1}. ${restaurant.menus['drinks'][i]['name']}"
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                  restaurant.pictureId,
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
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(
                    color: Colors.blueGrey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(
                          Icons.pin_drop,
                          color: Colors.red,
                          size: 20,
                        ),
                        Text(restaurant.city,
                            style: Theme.of(context).textTheme.labelMedium),
                      ]),
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
                          Text(restaurant.rating.toString(),
                              style: Theme.of(context).textTheme.labelMedium),
                        ],
                      ),
                    ],
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(60),
            right: Radius.circular(15),
          ),
        ),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Menu',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 50, fontWeight: FontWeight.bold),
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
                                children: _buldMenus(context),
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
      ),
    );
  }
}
