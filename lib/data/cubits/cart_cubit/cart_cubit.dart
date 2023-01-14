// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jbk_task/repositories/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.repository})
      : super(const CartState(cartItems: [], cartItemIds: [])) {
    getCart();
    // deleteCart();
  }

  late List<Map<String, dynamic>> cartItems;
  late List<int> cartItemIds;
  final CartRepository repository;

  deleteCart() async {
    var cartBox = await Hive.openBox('cartBox');
    cartBox.deleteFromDisk();
  }

  getCart() async {
    var cartBox = await Hive.openBox('cartBox');

    cartItems =
        cartBox.values.map((e) => Map<String, dynamic>.from(e)).toList();
    cartItemIds = cartBox.values.map<int>((e) => e['id']).toSet().toList();
    emit(CartState(cartItems: cartItems, cartItemIds: cartItemIds));
  }
}
