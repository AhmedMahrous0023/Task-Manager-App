import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/Core/Services/tasks_provider_service.dart';
import 'package:task_manager_app/Models/task_model.dart';
import 'package:task_manager_app/Views/Widgets/custom_text.dart';
import 'package:task_manager_app/Views/Widgets/my_custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
   final TextEditingController _taskController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TasksProvider>(context, listen: false).fetchTasks();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _taskController;
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
      if (!tasksProvider.isLoading) {
        tasksProvider.loadMoreTasks(); // Fetch more tasks on scroll end
      }
    }
  }

  void _toggleTaskCompletion(TaskModel task, bool? value) {
    if (value != null) {
      setState(() {
        task.isCompleted = value;
      });
    }
  }

  Future<void> _showDeleteDialog(BuildContext context, TaskModel task) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Provider.of<TasksProvider>(context, listen: false)
                    .deleteTask(task);
                Navigator.of(context).pop(); 
              },
            ),
          ],
        );
      },
    );
  }


  void _addTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: _taskController,
            decoration: const InputDecoration(hintText: 'Enter task name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _taskController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final taskName = _taskController.text;
                if (taskName.isNotEmpty) {
                  final newTask = TaskModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    taskName: taskName,
                    isCompleted: false,
                    userId: 1, // Example userId
                  );

                  Provider.of<TasksProvider>(context, listen: false)
                      .addTask(newTask);
                  _taskController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const CustomText(text: 'My Tasks'),
      ),
      drawer: CustomDrawer(),
      body: tasksProvider.isLoading
          ? const SafeArea(child:  Center(child: CircularProgressIndicator()))
          : tasksProvider.myTasks.isNotEmpty
              ? 
              SafeArea(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: tasksProvider.myTasks.length +
                        (tasksProvider.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == tasksProvider.myTasks.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final task = tasksProvider.myTasks[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Dismissible(
                          key: Key(task.id
                              .toString()), 
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            final bool? res = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete Task'),
                                  content: const Text(
                                      'Are you sure you want to delete this task?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return res ?? false;
                          },
                          onDismissed: (direction) {
                            Provider.of<TasksProvider>(context, listen: false)
                                .deleteTask(task);
                          },
                          background: Container(
                            color: Colors.red[100],
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: Card(
                            color: task.isCompleted
                                ? Colors.indigo[100]
                                : Colors.amber[100],
                            child: ListTile(
                              title: Text(
                                task.taskName,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              trailing: Checkbox(
                                value: task.isCompleted,
                                onChanged: (value) =>
                                    _toggleTaskCompletion(task, value),
                              ),
                              
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      tasksProvider.fetchTasks();
                    },
                    child:const Card(
                      child: Row(
                        children: [
                          Icon(Icons.expand_more_outlined),
                          CustomText(text: 'Show More Tasks')
                        ],
                      ),
                    ),
                  ),
                ),
      floatingActionButton: tasksProvider.myTasks.isNotEmpty
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                _addTask(context);
              },
            )
          : null,
    );
  }
}
