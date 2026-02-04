enum SensorType {
  humidity,
  temperature,
  light,
}

class Sensor {
  final int id;
  final String name;
  final double value;

  const Sensor({required this.id, required this.name, required this.value});

  factory Sensor.fromJson(Map sensor) => Sensor(
      id: sensor["id"],
      name: sensor["name"],
      value: sensor["value"].toDouble());
}
