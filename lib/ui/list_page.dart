import 'package:flutter/material.dart';
import 'package:myrestaurant/provider/restaurant_list_provider.dart';
import 'package:myrestaurant/ui/search_page.dart';
import 'package:myrestaurant/utils/result_state.dart';
import 'package:myrestaurant/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Restaurant",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, SearchPage.routeName),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
            ),
          ),
          _buildRestaurantItem(context),
        ],
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

Widget _buildRestaurantItem(BuildContext context) {
  return Consumer<RestaurantListProvider>(
    builder: (context, state, child) {
      if (state.state == ResultState.loading) {
        return SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      } else if (state.state == ResultState.hasData) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: state.result.restaurants.length,
            (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          ),
        );
      } else if (state.state == ResultState.noData) {
        return SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      } else if (state.state == ResultState.error) {
        return SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    onPressed: () => state.updateData(),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return const Center(
          child: SliverToBoxAdapter(
            child: Text(''),
          ),
        );
      }
    },
  );
}
