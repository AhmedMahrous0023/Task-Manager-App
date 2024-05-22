
class TaskDataSource {
  final List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
  }

  List<Task> getAllTasks() {
    return List.from(tasks); 
  }
   void updateTask(Task oldTask, Task newTask) {
    final index = tasks.indexWhere((task) => task == oldTask);
    if (index != -1) {
      tasks[index] = newTask;
    }
  }
  void deleteTask(Task task) {
    tasks.removeWhere((t) => t == task);
  }
}

class Task {
  final String title;
  final String description;

  Task({required this.title, required this.description});
}
