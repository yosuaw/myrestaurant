import 'package:flutter/material.dart';
import 'package:myrestaurant/provider/database_provider.dart';
import 'package:myrestaurant/utils/result_state.dart';
import 'package:myrestaurant/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Restaurants",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: provider.favorites.length,
                itemBuilder: (context, index) {
                  return CardRestaurant(restaurant: provider.favorites[index]);
                },
              ),
            );
          } else if (provider.state == ResultState.loading) {
            return const Center(
              child: Material(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            return Center(
              child: Material(
                child: Text(provider.message),
              ),
            );
          }
        },
      ),
    );
  }
}
