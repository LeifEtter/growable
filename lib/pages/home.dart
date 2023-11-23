import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:growable/database/plant.dart';
import 'package:growable/models/plant.dart';
import 'package:growable/widgets/plant_card.dart';
import 'package:word_generator/word_generator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Plant> allPlants;
  static PlantDatabase db = PlantDatabase();

  @override
  void initState() {
    db.getAll().then((List<Plant> plants) => allPlants = plants);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text("Welcome"),
            const Text("Meiqiu Etter"),
            const Text("Tasks"),
            TextButton(
              child: const Text("Add Random Plant"),
              onPressed: () async {
                PlantDatabase db = PlantDatabase();
                db.createPlant(Plant(
                  name: WordGenerator().randomName(),
                  description: WordGenerator().randomSentence(),
                  optimalHumidity: Random().nextInt(100),
                  optimalTemperature: Random().nextInt(100),
                  waterRequirements: WaterRequirements.medium,
                ));
              },
            ),
            FutureBuilder(
              future: db.getAll(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Plant>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const Text("Loading");
                }
                List<Plant> plants = snapshot.data!;
                return CarouselSlider(
                  items: plants
                      .map((Plant plant) => Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: PlantCard(plant: plant),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    padEnds: false,
                    enableInfiniteScroll: false,
                    enlargeFactor: 0.2,
                    viewportFraction: 0.4,
                    enlargeCenterPage: false,
                    height: 250,
                    pageSnapping: true,
                  ),
                );
              },
            ),
            Text("Tasks"),
          ],
        ),
      ),
    );
  }
}
