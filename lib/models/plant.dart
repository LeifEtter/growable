enum WaterRequirements {
  low,
  medium,
  high,
}

enum WateringUrgency { low, medium, high, danger }

class Plant {
  const Plant({
    required this.name,
    required this.description,
    required this.optimalHumidity,
    required this.optimalTemperature,
    required this.waterRequirements,
  });

  final String name;
  final String description;
  final int optimalHumidity;
  final int optimalTemperature;
  final WaterRequirements waterRequirements;

  factory Plant.fromJson(dynamic json) => Plant(
        name: json["name"],
        description: json["description"],
        optimalHumidity: json["optimal_humidity"],
        optimalTemperature: json["optimal_temperature"],
        waterRequirements: WaterRequirements.values
            .byName(json["water_requirements"].toString().toLowerCase()),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "optimal_humidity": optimalHumidity,
        "optimal_temperature": optimalTemperature,
        "water_requirements": waterRequirements.name
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
}
