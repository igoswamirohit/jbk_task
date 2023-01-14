// ignore: depend_on_referenced_packages
import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jbk_task/repositories/ticket_repository.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit(this.ticketList, {required TicketRepository repository})
      : super(TicketState(ticketList));

  List<String> ticketList;
  int replaceIndex = 0;

  Future<int> addToCart(int? id) async {
    var cartBox = await Hive.openBox('cartBox');
    return cartBox.add({'id': id ?? '', 'ticketNumbers': ticketList});
  }

  String? addNumber(int number) {
    if (ticketList.contains(number.toString())) {
      return "Number already Exists";
    }
    ticketList[replaceIndex] = number.toString();
    replaceIndex++;
    if (replaceIndex == 5) replaceIndex = 0;
    emit(TicketState(ticketList));
    return null;
  }

  void setRandomNumbers() {
    Set<int> randomNumbers = {};
    while (randomNumbers.length < 5) {
      randomNumbers.add(Random().nextInt(36) + 1);
    }
    ticketList = randomNumbers.map((e) => e.toString()).toList();
    emit(TicketState(ticketList));
  }

  void clear() {
    ticketList = List.filled(5, '');
    replaceIndex = 0;
    emit(TicketState(ticketList));
  }
}
