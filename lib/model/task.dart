class Todo {
  final String? id;
  final String? name;
  bool isDone;  

  Todo({
    this.id,
    this.name,
    this.isDone = false, 
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      name: json['name'],
      isDone: json['is_done'] ?? false, 
    );
  }
}
