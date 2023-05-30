
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list/models/task.dart';
import 'package:task_list/widgets/task_item.dart';

import '../providers/tasks_provider.dart';
import 'no_tasks.dart';

// ignore: must_be_immutable
class TaskList extends StatefulWidget {
  TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  //List<Task> tasks;
  @override
  Widget build(BuildContext context) {

    final tasks = Provider.of<TaskProvider>(context);

    List<Widget> _generateListTasks(List<Task> tasks) {
      return tasks.map((ta) => TaskItem(ta)).toList();
    }

    return FutureBuilder<List<Task>>(
      future: tasks.list(), //LugarService().list(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasError) {
          return Center(child: Center(child: Text("Erro ao consultar dados: ${snapshot.error}"),),);
        } else if (snapshot.hasData){
          final list = snapshot.data;
          if(list != null && list.isNotEmpty){
            return ChangeNotifierProvider(
              create: (context) => TaskProvider(),
              child: ListView(
                children: _generateListTasks(list),
              ),
            );
          } else {
            return const Center(child: Text("Nenhum Lugar Cadastrado."),);  
          }
        } else {
          return const Center(child: Text("Nenhum Lugar Cadastrado."),);
        }
      },
    );

    // return ChangeNotifierProvider(
    //   create: (context) => TaskProvider(),
    //   child: Container(
    //     child: tasks.items.isEmpty
    //         ? NoTasks()
    //         :
    //         ListView(
    //           children: _generateListTasks(context),
    //         )
    //   ),
    // );
  }
}
