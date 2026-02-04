import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:word_generator/word_generator.dart';

enum WaterRequirements {
  low,
  medium,
  high,
}

enum WateringUrgency { low, medium, high, danger }

class Plant {
  const Plant({
    this.id,
    required this.name,
    required this.description,
    required this.optimalHumidity,
    required this.optimalTemperature,
    required this.waterRequirements,
    this.image,
  });

  final int? id;
  final String name;
  final String description;
  final int optimalHumidity;
  final int optimalTemperature;
  final WaterRequirements waterRequirements;
  final String? image;

  factory Plant.fromJson(dynamic json) => Plant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        optimalHumidity: json["optimal_humidity"],
        optimalTemperature: json["optimal_temperature"],
        waterRequirements: WaterRequirements.values
            .byName(json["water_requirements"].toString().toLowerCase()),
        image: json["image"],
      );

  factory Plant.random() => Plant(
        name: WordGenerator().randomName(),
        description: WordGenerator().randomSentence(),
        optimalHumidity: Random().nextInt(50),
        optimalTemperature: Random().nextInt(30),
        waterRequirements: _getRandomWaterRequirements(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "optimal_humidity": optimalHumidity,
        "optimal_temperature": optimalTemperature,
        "water_requirements": waterRequirements.name,
        "image": image,
      };

  WateringUrgency needsWatering(int moisture) {
    if (moisture < 1500) {
      return WateringUrgency.low;
    } else if (moisture < 2500) {
      return WateringUrgency.medium;
    } else if (moisture < 3000) {
      return WateringUrgency.high;
    } else {
      return WateringUrgency.danger;
    }
  }

  Future<Plant> generateMock() async => Plant(
        name: await _getRandomPlantName(),
        description: WordGenerator().randomSentence(),
        optimalHumidity: Random().nextInt(50),
        optimalTemperature: Random().nextInt(30),
        waterRequirements: _getRandomWaterRequirements(),
      );

  static Future<String> _getRandomPlantName() async {
    http.Response res = await http.get(Uri.parse(
        "https://trefle.io/api/v1/plants?token=ObH4acUDiN70QeC-L3ZlebUoQbX_hC3YUdgtyF9PRDI"));
    var dec = await jsonDecode(res.body);
    var randomPlant = dec["data"][Random().nextInt(20)];
    return randomPlant["common_name"];
  }

  static WaterRequirements _getRandomWaterRequirements() {
    int randomNumber = Random().nextInt(3);
    if (randomNumber == 0) {
      return WaterRequirements.low;
    }
    if (randomNumber == 1) {
      return WaterRequirements.medium;
    }
    return WaterRequirements.high;
  }
}
