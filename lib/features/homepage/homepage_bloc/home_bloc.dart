import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sample_practise_bloc_app/data/cart_Items.dart';
import 'package:sample_practise_bloc_app/data/grocery_data.dart';
import 'package:sample_practise_bloc_app/data/wishlist_items.dart';
import '../models/product_model.dart';

part 'home_event.dart';

part 'home_state.dart';

//Core Business Logic For HomePage

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonNavigateEvent>(
        homeProductWishlistButtonNavigateEvent);
    on<HomeProductCartButtonNavigateEvent>(homeProductCartButtonNavigateEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    print("homeInitialEvent triggered !");
    emit(HomeLoadingState());
    await Future.delayed(
        const Duration(seconds: 3)); // to simulate fetching from firebase/db
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map(
              (e) => ProductModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                imageUrl: e['imageUrl'],
                price: e['price'],
                wishlisted: false,
              ),
            )
            .toList()));
  }

  FutureOr<void> homeProductWishlistButtonNavigateEvent(
      HomeProductWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Navigating to Wishlist");
    emit(NavigateToWishlistPageActionState()); //emitting an updated state
  }

  FutureOr<void> homeProductCartButtonNavigateEvent(
      HomeProductCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Navigating to your Cart");
    emit(NavigateToCartPageActionState()); //emitting an updated state
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Cart button clicked !");
    cart.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Wishlist button clicked !");
    wishList.add(event.wishedProduct);

    //sending data to bloc via an Event
    emit(HomeProductItemWishedActionState());
  }
}
