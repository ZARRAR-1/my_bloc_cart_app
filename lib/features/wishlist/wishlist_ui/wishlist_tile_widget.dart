import 'package:flutter/material.dart';
import 'package:sample_practise_bloc_app/features/homepage/models/product_model.dart';

import '../wishlist_bloc/wishlist_bloc.dart';

class WishlistTileWidget extends StatelessWidget {
  final ProductModel item;
  final WishlistBloc wishlistBloc;

  const WishlistTileWidget(
      {super.key, required this.item, required this.wishlistBloc});

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
                    fit: BoxFit.cover, image: NetworkImage(item.imageUrl))),
          ),
          const SizedBox(height: 20),
          Text(item.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(item.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${item.price}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        wishlistBloc.add(
                          RemoveFromWishlistEvent(item: item),
                        );
                      },
                      icon: const Icon(Icons.delete_forever_rounded)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
