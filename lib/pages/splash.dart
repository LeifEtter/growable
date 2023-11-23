import 'package:flutter/material.dart';
import 'package:growable/constants.dart';

const pages = ["page1", "page2"];
const currentSelectedPage = 1;

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GrowableColors.green,
      body: ListView(
        children: [
          const Text("Welcome"),
          const Text("Plant Plover"),
          const Text(
              "Taking care of plants can be tricky, you need to consider variables, such as lighting, watering and humidifying…"),
          Container(
            height: 12,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.red)),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pages.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.symmetric(vertical: 50),
                width: index == currentSelectedPage ? 30 : 10,
                decoration: BoxDecoration(
                  color: GrowableColors.yellowGreen,
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ),
          TextButton(
            child: const Text("Lets begin"),
            onPressed: () => {},
          ),
        ],
      ),
    );
  }
}
