import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jbk_task/data/models/charity_model.dart';

class CharityRepository {
  Future<List<Charity>> getCharities() async {
    return (jsonDecode(
            await rootBundle.loadString('assets/json/charities.json')) as List)
        .map((charity) => Charity.fromJson(charity))
        .toList();
  }
}
