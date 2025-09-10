part of 'home_bloc.dart';
//Home States, that are returned to the HomePage UI:

@immutable
abstract class HomeState {} ///Base class of all States especially Non-Action States

abstract class HomeActionState
    extends HomeState {}
///Base class of all Action States, i.e.
///All States that are a result of User Interaction on UI.

//Non-Action States:
class HomeInitialState extends HomeState {} //State emitted when the App starts

class HomeLoadingState
    extends HomeState {} //State emitted when the homepage is being loaded

class HomeLoadedSuccessState extends HomeState {
  //State emitted when the homepage is successfully loaded
  final List<ProductModel> products;

  HomeLoadedSuccessState({required this.products});
 }

class HomeErrorState
    extends HomeState {} // State emitted when the homepage is NOT loaded successfully

//Action States:
class NavigateToWishlistPageActionState
    extends HomeActionState {}
///State emitted when the User Clicks Navigate To Wishlist

class NavigateToCartPageActionState
    extends HomeActionState {}
///State emitted when the User Clicks Navigate To Cart

class HomeProductItemWishedActionState extends HomeActionState {}

class HomeProductItemCartedActionState extends HomeActionState {}