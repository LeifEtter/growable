enum TaskType {
  water,
}

enum TaskImportance {
  high,
  medium,
  low,
}

class Task {
  Task({
    required this.plant,
    required this.type,
    required this.importance,
  });

  String plant;
  TaskType type;
  TaskImportance importance;
}
