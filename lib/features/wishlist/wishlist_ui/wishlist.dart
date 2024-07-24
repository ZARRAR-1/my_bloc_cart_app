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
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    super.initState();
    wishlistBloc.add(WishlistInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        buildWhen: (previous, current) => current is! WishlistActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case (WishlistSuccessState):
              {
                final successState = state as WishlistSuccessState;
                return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: (context, index) {
                    return WishlistTileWidget(
                      item: successState.wishlistItems[index],
                      wishlistBloc: wishlistBloc,
                    );
                  },
                );
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
        listener: (context, state) {},
      ),
    );
  }
}
