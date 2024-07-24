part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

abstract class WishlistActionState {}

final class WishlistInitialState extends WishlistState {}

final class WishlistLoadingState extends WishlistState{

}

final class WishlistSuccessState extends WishlistState {
  final List<ProductModel> wishlistItems;

  WishlistSuccessState({required this.wishlistItems});
}

