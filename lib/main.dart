import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:growable/database/plant.dart';
import 'package:growable/models/plant.dart';
import 'package:growable/pages/home.dart';
import 'package:growable/pages/splash.dart';
import 'package:growable/theme/theme.dart';
import 'package:word_generator/word_generator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo', theme: CustomTheme().theme, home: const Home());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += 1031903942;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
                onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => const Splash())),
                    },
                child: const Text("Navigate to Splash Screen")),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
