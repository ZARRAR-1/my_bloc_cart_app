part of 'home_bloc.dart';

///Home Events that are triggered from the HomePage UI:

@immutable
abstract class HomeEvent {}

class HomeInitialEvent
    extends HomeEvent {} //Triggered inside initState when the page is first loaded

class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductModel wishedProduct; //product which is wishlisted

  HomeProductWishlistButtonClickedEvent({required this.wishedProduct});
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductModel clickedProduct; //product which is carted

  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class HomeProductWishlistButtonNavigateEvent extends HomeEvent {}

class HomeProductCartButtonNavigateEvent extends HomeEvent {}
