import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_practise_bloc_app/features/cart/cart_bloc/cart_bloc.dart';

import 'cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartBloc.add(CartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case (CartSuccessState):
              {
                final successState = state as CartSuccessState;
                return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                      product: successState.cartItems[index],
                      cartBloc: cartBloc,
                    );
                  },
                );
              }
            case (CartLoadingState):
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
                //Nothing
              }
          }
          return Container();
        },
        listenWhen: (previous, current) => current is CartActionState,
        listener: (context, state) {},
      ),
    );
  }
}
