import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/tasks_provider.dart';
import '../services/tasks_service.dart';
//import '../widgets/chart.dart';
import '../widgets/new_task.dart';
import '../widgets/task_item.dart';
import '../widgets/task_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  void _startAddNewTask(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTask();
      },
    );
  }

  
  @override
  Widget build(BuildContext context) {

    

    final appBar = AppBar(
        title: Text("Lista de Tarefas"),
        actions: [
          Builder(
              builder: (context) => IconButton(
                  onPressed: () => _startAddNewTask(context),
                  icon: Icon(Icons.add))
                  )
        ],
      );

    
    return Scaffold(
      appBar: appBar,
      body: TaskList(),

      // FutureBuilder<List<Task>>(
      //     future: TasksService().list(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return const Center(child: CircularProgressIndicator(), );
      //       } else if (snapshot.hasError) {
      //         return Center( child: Text('Erro ao consultar dados! ${snapshot.error}'), );
      //       } else if (snapshot.hasData) {
      //         final list = snapshot.data;
      //         if (list != null && list.isNotEmpty) {

      //           var taskListContainer = Container(
      //                     child: TaskList(), 
      //                     height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.70,
      //                   );
                

      //           return SingleChildScrollView(
      //             child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.stretch,
      //                 children: <Widget>[
      //                   taskListContainer,
      //                 ]),
      //           );
                
      //         } else {
      //           return Center( child: Text('Erro ao consultar dados! ${snapshot.error}'), );
      //         }
      //       } else {
      //         return Center( child: Text('Erro ao consultar dados! ${snapshot.error}'), );
      //       }
      //     }
      //     ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTask(context),
        ),
      ),
    );
  }
}
