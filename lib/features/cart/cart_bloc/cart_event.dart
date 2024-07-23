part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class RemoveFromCartEvent extends CartEvent {
  final ProductModel product;

  RemoveFromCartEvent({required this.product});
}

//TO-DO:
//Add Scaffold message once you delete item from cart
//Complete wishlist part.

