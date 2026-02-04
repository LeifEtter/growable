import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:growable/constants.dart';
import 'package:growable/database/plant_database.dart';
import 'package:growable/models/plant.dart';
// import 'package:growable/models/task.dart';
import 'package:growable/theme/custom_text.dart';
import 'package:growable/widgets/plant_card.dart';
// import 'package:growable/widgets/task_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:word_generator/word_generator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Plant> allPlants;
  static PlantDatabase plantDb = PlantDatabase();
  SupabaseClient db = Supabase.instance.client;

  @override
  void initState() {
    plantDb.getAll().then((List<Plant> plants) => allPlants = plants);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Welcome",
                  style: TextStyle(
                    color: GrowableColors.green,
                  )),
              const Text("Meiqiu Etter"),
              Text("Your Plants", style: CustomText().greenHeader),
              TextButton(
                child: Text("Login"),
                onPressed: () async {
                  AuthResponse res = await db.auth.signInWithPassword(
                    email: "flutter-app@growable.com",
                    password: "flutter1234sup@",
                  );
                  print(res);
                },
              ),
              TextButton(
                child: const Text("Add Random Plant"),
                onPressed: () async {
                  PlantDatabase db = PlantDatabase();
                  db.savePlant(Plant(
                    name: WordGenerator().randomName(),
                    description: WordGenerator().randomSentence(),
                    optimalHumidity: Random().nextInt(100),
                    optimalTemperature: Random().nextInt(100),
                    waterRequirements: WaterRequirements.medium,
                  ));
                },
              ),
              FutureBuilder(
                future: plantDb.getAll(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Plant>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return const Text("Loading");
                  }
                  List<Plant> plants = snapshot.data!;
                  return CarouselSlider(
                    items: plants
                        .map((Plant plant) => Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: PlantCard(plant: plant),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      padEnds: false,
                      enableInfiniteScroll: false,
                      enlargeFactor: 0.2,
                      viewportFraction: 0.5,
                      enlargeCenterPage: false,
                      height: 250,
                      pageSnapping: true,
                    ),
                  );
                },
              ),
              // Text(
              //   "Tasks",
              //   style: CustomText().greenHeader,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Column(
              //     children: [
              //       TaskCard(
              //         task: Task(
              //           plantId: "1lMXzRSQch80bOBrXue3",
              //           type: TaskType.water,
              //           urgency: TaskUrgency.high,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
