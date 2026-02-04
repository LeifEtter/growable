import 'package:flutter/material.dart';
import 'package:growable/constants.dart';
import 'package:growable/models/task.dart';

class TaskCard extends StatefulWidget {
  final Task task;

  const TaskCard({
    required this.task,
    super.key,
  });

  const TaskCard.water({
    required this.task,
    super.key,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late Color backgroundColor;

  @override
  void initState() {
    backgroundColor = GrowableColors.green;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Column(
        children: [
          Text("Water the Plant"),
          Text("Monstera"),
        ],
      ),
    );
  }
}
