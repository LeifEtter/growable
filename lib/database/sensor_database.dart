import 'dart:developer';
import 'package:growable/models/plant.dart';
import 'package:growable/models/sensor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SensorDatabase {
  SupabaseClient db = Supabase.instance.client;

  Future<List<Sensor>> getAll() async {
    try {
      List results = await db.from("sensors").select();

      List<Sensor> result =
          results.map<Sensor>((sensor) => Sensor.fromJson(sensor)).toList();
      return result;
    } catch (error) {
      log(error.toString());
      throw Error();
    }
  }

  Future<bool> saveSensor(Plant plant) async {
    try {
      List result = await db.from("sensors").insert(plant.toJson()).select();
      print(result);
      return true;
    } catch (error) {
      log(error.toString());
      throw Error();
    }
  }

  Future<void> deletePlant(String id) async {
    try {
      await db.from("sensors").delete().match({"id": id});
    } catch (error) {
      log(error.toString());
    }
  }
}
