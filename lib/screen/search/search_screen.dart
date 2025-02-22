import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/provider/search/search_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';
import 'package:restaurant_app/widgets/card/restaurant_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "CariIn Restaurant",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.primary,
                  iconColor: Theme.of(context).colorScheme.primary,
                  focusColor: Theme.of(context).colorScheme.primary,
                  hoverColor: Theme.of(context).colorScheme.primary,
                  hintText: 'Cari restoran...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    context.read<RestaurantSearchProvider>().searchRestaurants(
                      query,
                    );
                  } else {
                    context
                        .read<RestaurantSearchProvider>()
                        .clearSearchResults();
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Consumer<RestaurantSearchProvider>(
              builder: (context, provider, child) {
                if (provider.resultState is RestaurantSearchLoadingState) {
                  return Center(
                    child: Lottie.asset(
                      "assets/lottie/loading.json",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                if (provider.resultState is RestaurantSearchErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lottie/error.json", height: 200),
                        const SizedBox(height: 10),
                        Text(
                          "Oops! Terjadi kesalahan.",
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Periksa Koneksi Internet Anda.",
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (provider.resultState is RestaurantSearchEmptyState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          "assets/lottie/empty.json",
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Oops! Restoran tidak ditemukan.",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (provider.resultState is RestaurantSearchLoadedState) {
                  final restaurants =
                      (provider.resultState as RestaurantSearchLoadedState)
                          .data;
                  return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.41,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: RestaurantCard(
                            restaurant: restaurant,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                NavigationRoute.detailRoute.name,
                                arguments: restaurant.id,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "assets/lottie/search.json",
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Cari berdasarkan nama dan kategori restoran.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
