import 'package:flutter/material.dart';
import 'package:sample_practise_bloc_app/features/homepage/homepage_bloc/home_bloc.dart';
import 'package:sample_practise_bloc_app/features/homepage/models/product_model.dart';

class ProoductTileWidget extends StatelessWidget {
  final ProductModel _product;
  final HomeBloc _homeBloc;

  const ProoductTileWidget(
      {super.key, required ProductModel product, required HomeBloc homeBloc}) : _homeBloc = homeBloc, _product = product;

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
                    fit: BoxFit.cover, image: NetworkImage(_product.imageUrl))),
          ),
          const SizedBox(height: 20),
          Text(_product.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(_product.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rs. ${_product.price}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _homeBloc.add(
                          HomeProductWishlistButtonClickedEvent(
                              wishedProduct: _product),
                        );

                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        _homeBloc.add(HomeProductCartButtonClickedEvent(
                            clickedProduct: _product));
                      },
                      icon: const Icon(Icons.shopping_bag_outlined)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
