import 'package:equatable/equatable.dart';

class Todo extends Equatable{
  final String id;
  final String task;
  final String description;
  bool? isCompleted;
  bool? isCancelled;

  Todo({
    required this.id,
    required this.task,
    required this.description,
    this.isCompleted,
    this.isCancelled
  }){
    isCompleted = isCompleted ?? false;
    isCancelled = isCancelled ?? false;
  }

  Todo copyWith({
    String? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }){
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isCancelled: isCancelled ?? this.isCancelled
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    task,
    description,
    isCompleted,
    isCancelled,
  ];

  static List<Todo> todos = [
    Todo(
      id : '1',
      task: "Todo 1",
      description: "First todo to do",
    ),
    Todo(
      id : '2',
      task: "Todo 2",
      description: "Second todo to do",
    ),
  ];
}

