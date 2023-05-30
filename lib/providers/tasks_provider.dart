
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';
import '../services/tasks_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> items = [
    //  Task(title: "teste", date: DateTime.now(), id: "12345")
  ];


  var service = TasksService();

  
  
  Future<List<Task>> list() async {
    if(items.isEmpty){
      items = await service.list();
    }
    return items;
  }

  void deleteTask(Task task) async {
    TasksService tasksService = TasksService();
    await tasksService.delete(task.id!);
    // print(items);
    // var teste = items.where((element) => element.id == task.id);
    // print(teste); 
    items.remove(task);
    notifyListeners();
  }



  void addTask(Task task){
    task.id = DateTime.now().toString();
    service.insert(task);
    items.add(task);
    notifyListeners();
  }


  void editTask(String id, Task task){
    service.update(id, task);
    items.removeWhere((element) => element.id == id);
    items.add(task);
    
    notifyListeners();
    
  }

  int totalTasks() => items.length;


}