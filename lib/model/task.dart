class Todo {
  final String? id;
  final String? name;
  bool isDone;  // Thay đổi thành biến có thể thay đổi

  Todo({
    this.id,
    this.name,
    this.isDone = false, // Giá trị mặc định
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      name: json['name'],
      isDone: json['is_done'] ?? false, // Giả sử backend trả về trường này
    );
  }
}
