import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_practise_bloc_app/features/cart/cart_ui/cart.dart';
import 'package:sample_practise_bloc_app/features/homepage/home_ui/prooduct_tile_widget.dart';
import 'package:sample_practise_bloc_app/features/homepage/homepage_bloc/home_bloc.dart';
import 'package:sample_practise_bloc_app/features/wishlist/wishlist_ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent()); //Triggered the Initial Event
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      listener: (BuildContext context, HomeState state) {
        if (state is NavigateToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Cart(),
            ),
          );
        } else if (state is NavigateToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Wishlist(),
            ),
          );
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item Added To Cart !'),
              duration: Duration(seconds: 1),
            ),
          );
        } else if (state is HomeProductItemWishedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item Added To Wishlist !'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      buildWhen: (previous, current) => current is! HomeActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeLoadedSuccessState):
            final successState = state as HomeLoadedSuccessState;
            // HomeLoadedSuccessState success;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                        HomeProductWishlistButtonNavigateEvent(),
                      );
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                        HomeProductCartButtonNavigateEvent(),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
                title: const Text(
                  'Baharaan Grocery App',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  semanticsLabel: "Baharaan Grocery App",
                ),
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return ProoductTileWidget(
                    product: successState.products[index],
                    homeBloc: homeBloc,
                  );
                },
              ),
            );

          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              ),
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error Loading Home Page'),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
