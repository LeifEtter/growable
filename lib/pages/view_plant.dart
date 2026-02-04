import 'package:flutter/material.dart';
import 'package:growable/constants.dart';
import 'package:growable/models/plant.dart';
import 'package:growable/models/sensor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:collection/collection.dart';

class ViewPlant extends StatefulWidget {
  final Plant plant;

  const ViewPlant({
    super.key,
    required this.plant,
  });

  @override
  State<ViewPlant> createState() => _ViewPlantState();
}

class _ViewPlantState extends State<ViewPlant> {
  SupabaseClient db = Supabase.instance.client;
  List<Sensor> sensors = [];
  double? temperature;
  double? humidity;
  double? light;
  double? soilMoisture;
  double? waterLevel;

  @override
  void initState() {
    updateSensorDataOnChange();
    super.initState();
  }

  void updateSensorDataOnChange() {
    db.from("sensors").stream(primaryKey: ["id"]).listen((event) {
      updateSensors();
      Future.delayed(const Duration(milliseconds: 5000));
    });
  }

  void updateSensors() async {
    var result = await db
        .from("plants")
        .select("sensors(id, name, value)")
        .match({"id": widget.plant.id});
    List<dynamic> sensorsJson = result[0]["sensors"];
    setState(() {
      sensors = sensorsJson.map((e) => Sensor.fromJson(e)).toList();
      extractValues();
    });
  }

  void extractValues() async {
    Sensor? tempSensor =
        sensors.firstWhereOrNull((Sensor e) => e.name == "temperature");
    if (tempSensor != null) {
      temperature = tempSensor.value;
    }
    Sensor? humiditySensor =
        sensors.firstWhereOrNull((Sensor e) => e.name == "humidity");
    if (humiditySensor != null) {
      humidity = humiditySensor.value;
    }
    Sensor? lightSensor =
        sensors.firstWhereOrNull((Sensor e) => e.name == "light");
    if (lightSensor != null) {
      light = lightSensor.value;
    }
    Sensor? soilMoistureSensor =
        sensors.firstWhereOrNull((Sensor e) => e.name == "soil_moisture");
    if (soilMoistureSensor != null) {
      soilMoisture = soilMoistureSensor.value.roundToDouble();
    }
    Sensor? waterLevelSensor =
        sensors.firstWhereOrNull((Sensor e) => e.name == "water_level");
    if (waterLevelSensor != null) {
      waterLevel = waterLevelSensor.value;
    }
  }

  int calculateSoilMoisturePercentage(double soilMoisture) =>
      (100 - ((soilMoisture / 4095) * 100)).floor();

  Widget TestBorder({required Widget child}) => Container(
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.orange)),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: -150,
              top: 30,
              child: Container(
                width: 500,
                height: 650,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.plant.image!),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    widget.plant.name,
                    style: const TextStyle(
                      color: Color(0xff2C6E49),
                      fontWeight: FontWeight.w600,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                temperature != null
                    ? indicator(
                        unit: "°C",
                        name: "Temperature",
                        value: temperature!,
                        icon: Icons.thermostat)
                    : Container(),
                humidity != null
                    ? indicator(
                        unit: "%",
                        name: "Humidity",
                        value: humidity!,
                        icon: Icons.water_drop_outlined)
                    : Container(),
                soilMoisture != null
                    ? indicator(
                        unit: "%",
                        name: "Soil Moisture",
                        value: soilMoisture!,
                        icon: Icons.water)
                    : Container(),
                light != null
                    ? indicator(
                        name: "Light Exposure",
                        value: light!,
                        icon: Icons.wb_sunny_outlined)
                    : Container(),
                waterLevel != null
                    ? indicator(
                        name: "Water Level",
                        value: waterLevel!,
                        icon: Icons.height_rounded)
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 50.0),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Color(0xffF7CBBC),
                        borderRadius: BorderRadius.circular(25.0)),
                    child: const DefaultTextStyle(
                      style: TextStyle(color: Color(0xff2C6E49)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fix Now",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Refill Water",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text("Water Soil",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Color(0xff2C6E49),
                    ),
                    child: Text(
                      "Show Optimal Levels",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: GrowableColors.yellowGreen,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget indicator({
    required String name,
    required dynamic value,
    required IconData icon,
    String unit = "",
  }) =>
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: Color(0xff2C6E49),
              ),
            ),
            Row(
              children: [
                Icon(icon, color: const Color(0xff2C6E49), size: 35.0),
                const SizedBox(width: 5.0),
                Text("$value$unit",
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2C6E49),
                    )),
              ],
            )
          ],
        ),
      );
}
