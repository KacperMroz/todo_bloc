import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todos/todos_bloc.dart';
import '../models/models.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a ToDo'),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('ToDo Added')));
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _inputField('ID', controllerId),
                _inputField('Task', controllerTask),
                _inputField('Descritpion', controllerDescription),
                ElevatedButton(
                  onPressed: () {
                    var todo = Todo(
                      id: controllerId.value.text,
                      task: controllerTask.value.text,
                      description: controllerDescription.value.text,
                    );
                    context.read<TodosBloc>().add(
                          AddTodo(todo: todo),
                        );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: const Text('Add ToDo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Column _inputField(String field, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        field,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        height: 30,
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        child: TextFormField(
          controller: controller,
        ),
      )
    ],
  );
}
