part of 'todos_bloc.dart';

@immutable
abstract class TodosEvent extends Equatable {

  @override
  List<Object> get props => [];
}


class LoadTodos extends TodosEvent {
  final List<Todo> todos;

  LoadTodos({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}

class AddTodo extends TodosEvent {
  final Todo todo;

  AddTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodosEvent {
  final Todo todo;

  UpdateTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodosEvent {
  final Todo todo;

  DeleteTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}