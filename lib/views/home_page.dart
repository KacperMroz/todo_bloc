import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/models/models.dart';

import '../blocs/todos/todos_bloc.dart';
import '../blocs/todos_filter/todos_filter_bloc.dart';
import 'views.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BLoC TODO'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTodoPage()),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
          bottom: TabBar(
            onTap: (tabIndex) {
              switch (tabIndex) {
                case 0:
                  BlocProvider.of<TodosFilterBloc>(context).add(
                      const UpdateTodos(
                        todosFilter: TodosFilter.pending,
                      ));
                  break;
                case 1:
                  BlocProvider.of<TodosFilterBloc>(context).add(
                      const UpdateTodos(
                        todosFilter: TodosFilter.completed,
                      ));
              }
            },
            tabs: const [
              Tab(icon: Icon(Icons.pending,),),
              Tab(icon: Icon(Icons.add_task,),),
            ],
          ),
        ),
        body: TabBarView(
            children:[
              _todos('Pending  Todos'),
              _todos('Completed Todos'),
            ],
        ),
      ),
    );
  }

  BlocConsumer<TodosFilterBloc, TodosFilterState> _todos(String title) {
    return BlocConsumer<TodosFilterBloc, TodosFilterState>(
      listener: (context, state){
        if(state is TodosFilterLoaded){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('There are ${state.filteredTodos.length} To Dos')),
          );
        }
      },
      builder: (context, state) {
        if (state is TodosFilterLoading) {
          return const CircularProgressIndicator();
        }
        if (state is TodosFilterLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child:  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filteredTodos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _todoCard(context, state.filteredTodos[index]);
                  },
                )
              ],
            ),
          );
        } else {
          return const Text('error');
        }
      },
    );
  }
}

Card _todoCard(BuildContext context, Todo todo) {
  return Card(
    margin: const EdgeInsets.only(bottom: 8.0),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '#${todo.id}: ${todo.task}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<TodosBloc>().add(
                    UpdateTodo(
                      todo: todo.copyWith(isCompleted: true),
                    ),
                  );
                },
                icon: const Icon(Icons.add_task),
              ),
              IconButton(
                onPressed: () {
                  context.read<TodosBloc>().add(
                    DeleteTodo(todo: todo),
                  );
                },
                icon: const Icon(Icons.cancel),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
