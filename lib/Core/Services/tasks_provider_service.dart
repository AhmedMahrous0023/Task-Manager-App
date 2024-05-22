import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager_app/Core/My%20Offline%20DataBase/database_helper.dart';
import 'package:task_manager_app/Models/task_model.dart';
import 'package:http/http.dart' as http;

class TasksProvider extends ChangeNotifier {
  final dbHelper = DatabaseHelper();

  List<TaskModel> _myTasks = [];

  List<TaskModel> get myTasks => _myTasks;

  int _currentPage = 0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  Future<void> fetchTasks([int page = 0]) async {
    setLoading(true);

    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/todos?limit=9&skip=${page * 9}'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data['todos'] != null) {
          final newTasks = (data['todos'] as List)
              .map((taskJson) => TaskModel.fromJson(taskJson))
              .toList();
          _myTasks.addAll(newTasks);
          notifyListeners();
          if (page == 0) {
            _myTasks = newTasks;
          } else {
            _myTasks.addAll(newTasks);
          }
          notifyListeners(); 
        } else {
          print('Failed to load tasks. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Failed to load tasks. Error: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadMoreTasks() async {
    _currentPage++;
    await fetchTasks(_currentPage);
  }

  void deleteTask(TaskModel task) async {
    myTasks.remove(task);
    await dbHelper.deleteTask(task.id);

    notifyListeners();
  }

  void addTask(TaskModel task) async {
    _myTasks.insert(0, task);
    await dbHelper.insertTask(task);
    notifyListeners();
  }

  Future<void> loadTasksFromDb() async {
    _myTasks = await dbHelper.getTasks();
    notifyListeners();
  }
}
