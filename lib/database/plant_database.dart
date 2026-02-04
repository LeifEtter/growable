import 'dart:developer';
import 'package:growable/models/plant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlantDatabase {
  SupabaseClient db = Supabase.instance.client;

  Future<List<Plant>> getAll() async {
    try {
      List<Map> result = await db.from("plants").select();
      List<Plant> plants =
          result.map<Plant>((plant) => Plant.fromJson(plant)).toList();
      return plants;
    } catch (error) {
      log(error.toString());
      throw Error();
    }
  }

  Future<Map> savePlant(Plant plant) async {
    try {
      List<Map> result =
          await db.from("plants").insert(plant.toJson()).select();
      return result[0];
    } catch (error) {
      log(error.toString());
      throw Error();
    }
  }

  Future<void> deletePlant(String id) async {
    try {
      await db.from("plants").delete().match({"id": id});
    } catch (error) {
      log(error.toString());
    }
  }
}
