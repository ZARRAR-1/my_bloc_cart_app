part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

final class WishlistInitialState extends WishlistState {}

final class WishlistLoadingState extends WishlistState {}

final class WishlistSuccessState extends WishlistState {
  final List<ProductModel> wishlistItems;

  WishlistSuccessState({required this.wishlistItems});
}

//Action State:
final class RemoveFromWishlistActionState extends WishlistActionState {}
