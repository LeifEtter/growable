import 'package:flutter/material.dart';
import 'package:growable/constants.dart';
import 'package:growable/models/plant.dart';
import 'package:growable/pages/view_plant.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({
    super.key,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => ViewPlant(plant: plant))),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: GrowableColors.pink,
        ),
      ),
    );
  }
}
