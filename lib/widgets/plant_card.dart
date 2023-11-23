import 'package:flutter/material.dart';
import 'package:growable/constants.dart';
import 'package:growable/models/plant.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({
    super.key,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: GrowableColors.pink,
      ),
    );
  }
}
