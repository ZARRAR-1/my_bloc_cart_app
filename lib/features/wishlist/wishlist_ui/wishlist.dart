import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_practise_bloc_app/features/wishlist/wishlist_bloc/wishlist_bloc.dart';
import 'package:sample_practise_bloc_app/features/wishlist/wishlist_ui/wishlist_tile_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  late final WishlistBloc _wishlistBloc;
  // final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    super.initState();
    _wishlistBloc.add(WishlistInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: _wishlistBloc,
        buildWhen: (previous, current) => current is! WishlistActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case (WishlistSuccessState):
              {
                final successState = state as WishlistSuccessState;
                if (successState.wishlistItems.isEmpty) {
                  return const Center(
                    child: Text(
                      'Your Wishlist is Empty Dear !', //NOT SHOWING UP
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: successState.wishlistItems.length,
                    itemBuilder: (context, index) {
                      return WishlistTileWidget(
                        item: successState.wishlistItems[index],
                        wishlistBloc: _wishlistBloc,
                      );
                    },
                  );
                }
              }
            case (WishlistLoadingState):
              {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  ),
                );
              }
            default:
              {
                //nothing
              }
          }
          return Container();
        },
        listenWhen: (previous, current) => current is WishlistActionState,
        listener: (BuildContext context, WishlistState state) {
          if (state is RemoveFromWishlistActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item Removed From Wishlist !'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
      ),
    );
  }
}
