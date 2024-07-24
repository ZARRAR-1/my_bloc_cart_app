part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class RemoveFromWishlistEvent extends WishlistEvent {
  final ProductModel item;

  RemoveFromWishlistEvent({required this.item});
}