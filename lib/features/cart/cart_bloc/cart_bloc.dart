import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sample_practise_bloc_app/features/homepage/models/product_model.dart';
import '../../../data/cart_Items.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<RemoveFromCartEvent>(removeFromCartEvent);
    // on<CartSuccessEvent>(cartSuccessEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    Future.delayed(
      const Duration(seconds: 3),
    );
    emit(
      CartSuccessState(cartItems: cart),
    );
  }

  FutureOr<void> removeFromCartEvent(
      RemoveFromCartEvent event, Emitter<CartState> emit) {
    cart.remove(event.product);
    emit(
      RemoveFromCartActionState(),
    );

    emit(
      CartSuccessState(cartItems: cart),
    );
  }
}
