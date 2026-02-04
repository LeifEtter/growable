enum TaskType {
  water,
}

enum TaskUrgency {
  high,
  medium,
  low,
}

class Task {
  Task({
    required this.plantId,
    required this.type,
    required this.urgency,
  });

  String plantId;
  TaskType type;
  TaskUrgency urgency;
}
