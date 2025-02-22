import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/provider/favorite/favorite_provider.dart';
import 'package:restaurant_app/static/favorite_result_state.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/widgets/card/favorite_restaurant_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final provider = context.read<FavoriteProvider>();
      await provider.checkInternetConnection();
      provider.loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restoran Favorit Kamu",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Consumer<FavoriteProvider>(
          builder: (context, provider, child) {
            final state = provider.state;

            if (state is FavoriteLoadingState) {
              return Center(
                child: Lottie.asset(
                  "assets/lottie/loading.json",
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              );
            } else if (state is FavoriteErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/lottie/error.json", height: 200),
                    const SizedBox(height: 10),
                    Text(
                      "Oops! Terjadi kesalahan.",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Periksa Koneksi Internet Anda.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is FavoriteLoadedState) {
              if (state.data.isEmpty) {
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
                      const SizedBox(height: 16),
                      Text(
                        "Kamu belum menambahkan favorit.",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final favorite = state.data[index];
                  final isConnected =
                      context.read<FavoriteProvider>().isConnected;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: FavoriteRestaurantCard(
                        favRestaurant: favorite,
                        onTap: () {
                          isConnected
                              ? Navigator.pushNamed(
                                context,
                                NavigationRoute.detailRoute.name,
                                arguments: favorite.id,
                              )
                              : ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Tidak ada koneksi internet!",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.onError,
                                    ),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                  behavior:
                                      SnackBarBehavior
                                          .floating, // Agar lebih modern
                                ),
                              );
                        },
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
