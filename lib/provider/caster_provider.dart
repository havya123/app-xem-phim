import 'package:baitap08/model/caster.dart';
import 'package:baitap08/repository/caster_repo.dart';
import 'package:flutter/material.dart';

class CasterProvider extends ChangeNotifier {
  Future<List<Caster>> getCaster(int id) async {
    var response = await CatersRepo().getCasters(id);
    return response;
  }
}
