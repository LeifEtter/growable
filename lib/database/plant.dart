import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growable/models/plant.dart';

class PlantDatabase {
  CollectionReference plants = FirebaseFirestore.instance.collection('plants');

  Future<List<Plant>> getAll() async {
    try {
      QuerySnapshot snapshot2 = await plants.get();
      List<Plant> result =
          snapshot2.docs.map<Plant>((plant) => Plant.fromJson(plant)).toList();
      return result;
    } catch (error) {
      log(error.toString());
      throw Error();
    }
  }

  Future<DocumentReference> createPlant(Plant plant) async {
    try {
      DocumentReference result = await plants.add(plant.toJson());
      return result;
    } catch (error) {
      log(error.toString());
      throw Error();
    }
  }
}
