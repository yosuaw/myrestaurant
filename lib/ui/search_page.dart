import 'package:flutter/material.dart';
import 'package:myrestaurant/provider/search_provider.dart';
import 'package:myrestaurant/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Restaurant",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
        child: Consumer<SearchProvider>(
          builder: (context, state, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Restaurant/Category/Menus",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey[800]),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.all(0),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                    ),
                    alignLabelWithHint: true,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  autofocus: true,
                  controller: state.controller,
                  onChanged: (_) => state.updateData(),
                ),
                _buildListSearch(context, state),
              ],
            );
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

Widget _buildListSearch(BuildContext context, SearchProvider state) {
  if (state.state == ResultState.loading) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: const Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  } else if (state.state == ResultState.noSearch) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              size: 200,
              color: Colors.grey[300],
            ),
            Text(
              'Try to search restaurant you want :)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  } else if (state.state == ResultState.hasData) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.builder(
          itemCount: state.result.restaurants.length,
          itemBuilder: (context, index) {
            return CardRestaurant(restaurant: state.result.restaurants[index]);
          },
        ),
      ),
    );
  } else if (state.state == ResultState.noData ||
      state.state == ResultState.error) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: Center(
        child: Text(
          state.message,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  } else {
    return const Text('');
  }
}
