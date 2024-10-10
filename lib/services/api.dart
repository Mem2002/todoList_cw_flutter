import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/utils/constants.dart';
import 'package:http/http.dart' as http;

class Api {
  static Future<void> updateTodoStatus(String id, bool isDone) async {
    try {
      var url = Uri.parse("${Constants.baseUrl}update_todo/$id");
      // Sử dụng http.post thay vì http.Request
      var response = await http.post(url, body: {
        "is_done": isDone.toString(),
      });

      // Kiểm tra mã trạng thái
      if (response.statusCode == 200) {
        print("Update successful");
      } else {
        print("Failed to update status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("An error occurred: $e");
    }
  }

  static Future<void> addProduct(Map<String, dynamic> data) async {
    try {
      var url = Uri.parse("${Constants.baseUrl}add_todo");

      // Kiểm tra xem 'name' có phải null không
      if (data['name'] == null) {
        print("Name cannot be null");
        return; // Không tiếp tục nếu name là null
      }

      // Gửi yêu cầu POST với body là một Map
      var response = await http.post(
        url,
        body: {
          "name": data["name"], // Truyền 'name' vào body
        },
      );

      // Kiểm tra mã trạng thái
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print(responseData); // In dữ liệu để kiểm tra
      } else {
        print("Failed to get response: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      debugPrint("An error occurred: $e");
    }
  }

  static Future<List<Todo>> getProduct() async {
    List<Todo> products = [];
    var url = Uri.parse("${Constants.baseUrl}get_todo");

    try {
      final res = await http.get(url);
      print('Status code: ${res.statusCode}');
      print('Response body: ${res.body}');

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print('Decoded data: $data');

        if (data is List) {
          products = data.map<Todo>((value) {
            print('Processing product: $value');
            return Todo(
              id: value['_id']?.toString() ?? '',
              name: value['name'] ?? '',
            );
          }).toList();
        } else {
          print("Unexpected data format: $data");
        }
      } else {
        print("Failed to load products. Status code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error occurred: ${e.toString()}");
    }
    return products;
  }

  static deleteTodo(String id) async {
    var url = Uri.parse("${Constants.baseUrl}delete/$id");
    final res = await http.delete(url); // Thay đổi thành http.delete
    if (res.statusCode == 204) {
      print("Todo deleted successfully.");
    } else {
      print("Failed to delete: ${res.statusCode}");
      print("Response body: ${res.body}");
    }
  }
}
