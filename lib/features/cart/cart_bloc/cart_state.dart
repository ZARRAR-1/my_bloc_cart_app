part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState {}

final class CartInitialState extends CartState {}

final class CartLoadingState extends CartState{

}

final class CartSuccessState extends CartState {
  final List<ProductModel> cartItems;

  CartSuccessState({required this.cartItems});
}
