import 'package:flutter_test/flutter_test.dart';

import 'task_data_source.dart';

void main() {
  group('Task CRUD Operations', () {
    test('Add Task', () {
      final dataSource = TaskDataSource();
      final newTask = Task(title: 'Test Task', description: 'This is a test task.');

      dataSource.addTask(newTask);

      expect(dataSource.tasks.length, 1);
      expect(dataSource.tasks.first.title, 'Test Task');
      expect(dataSource.tasks.first.description, 'This is a test task.');
    });
  });
}
