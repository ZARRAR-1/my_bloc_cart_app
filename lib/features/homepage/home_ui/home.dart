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
  late final HomeBloc _homeBloc;
  // final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.add(HomeInitialEvent()); //Triggered the Initial Event
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
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
        ///This variable - "state", holds the current state object emitted by your HomeBloc and is of type HomeState - base class.
        switch (state.runtimeType) {
          case const (HomeLoadedSuccessState):
            ///Downcasting the state object to HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            /// Now 'successState' is known to be of type HomeLoadedSuccessState
            /// and you can safely access its specific properties:
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      _homeBloc.add(
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
                      _homeBloc.add(
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
                    homeBloc: _homeBloc,
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
