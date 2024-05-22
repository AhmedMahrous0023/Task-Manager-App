import 'package:flutter_test/flutter_test.dart';

import 'task_data_source.dart';

void main() {
  group('Task CRUD Operations', () {
    test('Update Task', () {
      final dataSource = TaskDataSource();
      final originalTask = Task(title: 'Original Task', description: 'Original Description');
      final updatedTask = Task(title: 'Updated Task', description: 'Updated Description');

      dataSource.addTask(originalTask);
      dataSource.updateTask(originalTask, updatedTask);
      final allTasks = dataSource.getAllTasks();

      expect(allTasks.length, 1);
      expect(allTasks[0].title, 'Updated Task');
      expect(allTasks[0].description, 'Updated Description');
    });
  });
}
