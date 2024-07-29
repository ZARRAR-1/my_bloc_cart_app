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
                print('CartSuccessState');

                final successState = state as CartSuccessState;
                // print(successState.cartItems.length);
                if (successState.cartItems.isEmpty) {
                  // print('Your Cart is Empty Dear !');
                  return const Center(
                    child: Text(
                      'Your Cart is Empty Dear !',
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: successState.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartTileWidget(
                          product: successState.cartItems[index],
                          cartBloc: cartBloc,
                        );
                      });
                }
              }
            case (CartLoadingState):
              {
                print('Inside Cart Loading State');
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
        listener: (BuildContext context, CartState state) {
          if (state is RemoveFromCartActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item Removed From Cart !'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
      ),
      floatingActionButton: Container(
        width: 80,
        height: 40,

        child: FloatingActionButton(
          backgroundColor: Colors.blueGrey[300],
          foregroundColor: Colors.white,
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Text(
            'Checkout',
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
