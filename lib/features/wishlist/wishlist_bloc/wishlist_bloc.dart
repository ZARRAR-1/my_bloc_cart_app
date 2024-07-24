import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/wishlist_items.dart';
import '../../homepage/models/product_model.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitialState()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<RemoveFromWishlistEvent>(wishlistRemoveEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      event, Emitter<WishlistState> emit) async {
    print("wishlistInitialEvent triggered !");
    emit(WishlistLoadingState());
    await Future.delayed(
        const Duration(seconds: 2)); // to simulate fetching from firebase/db
    emit(
      WishlistSuccessState(wishlistItems: wishList),
    );
  }

  FutureOr<void> wishlistRemoveEvent(event, Emitter<WishlistState> emit) {
    wishList.remove(event.item);
    emit(
      WishlistSuccessState(wishlistItems: wishList),
    );
  }
}
