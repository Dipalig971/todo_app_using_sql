class TodoModal {
  int? id;
  String taskName;
  bool isDone;
  String note;
  int priority;

  TodoModal({
    this.id,
    required this.taskName,
    required this.isDone,
    required this.note,
    required this.priority,
  });

  factory TodoModal.fromJson(Map<String, dynamic> json) {
    return TodoModal(
      id: json['id'],
      taskName: json['taskName'],
      isDone: json['isDone'] == 1,
      note: json['note'],
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskName': taskName,
      'isDone': isDone ? 1 : 0,
      'note': note,
      'priority': priority,
    };
  }
}
