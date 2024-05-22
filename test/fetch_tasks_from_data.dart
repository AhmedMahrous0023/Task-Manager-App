// task_crud_test.dart

import 'package:flutter_test/flutter_test.dart';

import 'task_data_source.dart';

void main() {
  group('Task CRUD Operations', () {
    test('Fetch All Tasks', () {
      final dataSource = TaskDataSource();
      final task1 = Task(title: 'Task 1', description: 'Description 1');
      final task2 = Task(title: 'Task 2', description: 'Description 2');
      
      dataSource.addTask(task1);
      dataSource.addTask(task2);
      final allTasks = dataSource.getAllTasks();
      
      expect(allTasks.length, 2);
      expect(allTasks[0].title, 'Task 1');
      expect(allTasks[0].description, 'Description 1');
      expect(allTasks[1].title, 'Task 2');
      expect(allTasks[1].description, 'Description 2');
    });
  });
}
