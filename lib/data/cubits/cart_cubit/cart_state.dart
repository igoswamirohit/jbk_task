part of 'cart_cubit.dart';

class CartState extends Equatable {
  const CartState({required this.cartItems, required this.cartItemIds});

  final List<Map<String, dynamic>> cartItems;
  final List<int> cartItemIds;
  @override
  List<Object> get props => [];
}
