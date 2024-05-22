class TaskModel{

  String taskName ;
  int id ,userId;
  bool isCompleted ;

  TaskModel({required this.id,required this.taskName,required this.isCompleted,required this.userId});
  factory TaskModel.fromJson(Map<String,dynamic>json){
    return TaskModel(
      id: json['id'] as int, 
      taskName: json['todo'] as String,
       isCompleted: json['completed'] as bool,
       userId: json['userId']as int);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': taskName,
      'completed': isCompleted ? 1 : 0, 
      'userId': userId,
    };
  }
}