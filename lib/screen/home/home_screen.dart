import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_rating_provider.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/widgets/card/restaurant_card.dart';
import 'package:restaurant_app/widgets/card/restaurant_rating_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
      context.read<RestaurantRatingProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CariIn Restaurant",
            style: Theme.of(context).textTheme.headlineLarge),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       Navigator.pushNamed(
        //         context,
        //         NavigationRoute.searchRoute.name,
        //         arguments: 'cari restoran',
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, NavigationRoute.searchRoute.name);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 10),
                    Text(
                      "Cari restoran...",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer2<RestaurantRatingProvider, RestaurantListProvider>(
              builder: (context, ratingProvider, listProvider, child) {
                if (ratingProvider.resultState is RestaurantListLoadingState ||
                    listProvider.resultState is RestaurantListLoadingState) {
                  // Tampilkan hanya satu loading indikator
                  return Center(
                    child: Lottie.asset("assets/lottie/loading.json",
                        width: 200, height: 200, fit: BoxFit.cover),
                  );
                }

                if (ratingProvider.resultState is RestaurantListErrorState) {
                  // Tampilkan pesan error jika ada
                  final errorMessage =
                      (ratingProvider.resultState as RestaurantListErrorState)
                          .error;
                  return Center(
                    child: Text(errorMessage),
                  );
                }
                if (listProvider.resultState is RestaurantListErrorState) {
                  // Tampilkan pesan error jika ada
                  final errorMessage =
                      (listProvider.resultState as RestaurantListErrorState)
                          .error;
                  return Center(
                    child: Text(errorMessage),
                  );
                }

                // Data berhasil dimuat
                if (ratingProvider.resultState is RestaurantListLoadedState ||
                    listProvider.resultState is RestaurantListLoadedState) {
                  final restaurantRating =
                      (ratingProvider.resultState as RestaurantListLoadedState)
                          .data;
                  final restaurantList =
                      (listProvider.resultState as RestaurantListLoadedState)
                          .data;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text("Top Rating",
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.26,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurantRating.take(5).length,
                            itemBuilder: (context, index) {
                              final restaurant = restaurantRating[index];
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 8, bottom: 16),
                                  child: RestaurantRatingCard(
                                    restaurantRating: restaurant,
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text("Recommended For You",
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: restaurantList.length,
                          itemBuilder: (context, index) {
                            final restaurant = restaurantList[index];
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.41,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
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
                        ),
                      ],
                    ),
                  );
                }

                // Default fallback jika kondisi tidak dikenali
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
