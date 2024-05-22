import 'package:flutter_test/flutter_test.dart';

import 'task_data_source.dart';

void main() {
  group('Task CRUD Operations', () {
    test('Delete Task', () {
      final dataSource = TaskDataSource();
      final taskToDelete = Task(title: 'Task to Delete', description: 'Description to Delete');
      final taskToKeep = Task(title: 'Task to Keep', description: 'Description to Keep');

      dataSource.addTask(taskToDelete);
      dataSource.addTask(taskToKeep);
      dataSource.deleteTask(taskToDelete);
      final allTasks = dataSource.getAllTasks();

      expect(allTasks.length, 1);
      expect(allTasks[0].title, 'Task to Keep');
      expect(allTasks[0].description, 'Description to Keep');
    });
  });
}
