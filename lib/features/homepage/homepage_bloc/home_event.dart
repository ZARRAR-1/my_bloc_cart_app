part of 'home_bloc.dart';
//Home Events that are triggered from the HomePage UI:

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductModel wishedProduct;

  HomeProductWishlistButtonClickedEvent({required this.wishedProduct});
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductModel clickedProduct;

  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class HomeProductWishlistButtonNavigateEvent extends HomeEvent {}

class HomeProductCartButtonNavigateEvent extends HomeEvent {}
