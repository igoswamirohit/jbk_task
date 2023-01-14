// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/charity_repository.dart';
import '../../models/charity_model.dart';

part 'charity_state.dart';

class CharityCubit extends Cubit<CharityState> {
  CharityCubit({required this.repository})
      : super(const CharityState(charities: []));

  final CharityRepository repository;

  getCharities() async {
    final charities = await repository.getCharities();
    emit(CharityState(charities: charities));
  }
}
