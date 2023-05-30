import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/task.dart';
import '../providers/tasks_provider.dart';
import 'edit_task.dart';

class TaskItem extends StatefulWidget {
  const TaskItem(this.task, {super.key});

  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
    
    void _startEditTask(BuildContext ctx, Task task) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return EditTask(task: task);
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    final tasks = Provider.of<TaskProvider>(context);

      


    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: ListTile(
        title: Text(widget.task.title),
        subtitle: Text(widget.task.date.toString()),
        onTap: () => _startEditTask(context, widget.task),
        trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () =>
                        tasks.deleteTask(widget.task)
                      
                           ),
      ),
    );
  }
}