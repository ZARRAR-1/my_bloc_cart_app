import 'package:flutter/material.dart';
import 'package:sample_practise_bloc_app/features/homepage/models/product_model.dart';

import '../cart_bloc/cart_bloc.dart';

class CartTileWidget extends StatelessWidget {
  final ProductModel product;
  final CartBloc cartBloc;

  const CartTileWidget(
      {super.key, required this.product, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(product.imageUrl))),
          ),
          const SizedBox(height: 20),
          Text(product.name,
              style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(product.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rs. ${product.price}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        cartBloc.add(RemoveFromCartEvent(product: product));
                        // cartBloc.add(CartSuccessEvent);
                      },
                      icon: const Icon(Icons.delete)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
