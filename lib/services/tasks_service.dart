import 'dart:convert';

import 'package:http/http.dart';

import '../models/task.dart';
import '../repositories/tasks_repository.dart';

class TasksService {
  final TasksRepository _tasksRepository = TasksRepository();

  Future<List<Task>> list() async {
    try {
      Response response = await _tasksRepository.list();
      
      if (response.statusCode == 200){
        Map<String, dynamic> json = jsonDecode(response.body);
        return Task.listFromJson(json);
      }
      return [];
    } catch (e) {
      print (e);
      throw Exception('Problemas ao consultar lista. ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> insert(Task task) async {
    try {
      String json = jsonEncode(task.toJson());
      Response response = await _tasksRepository.insert(json);
      Map<String, dynamic> retorno = jsonDecode(response.body);
      //retorno.map((key, value) {return value;});
      return retorno;
    } catch (e) {
      throw Exception("Problemas ao inserir - ${e.toString()}");
    }
  }

  Future<bool> delete (String id) async {
    try {
      Response response = await _tasksRepository.delete(id);
      return response.statusCode == 200;
      //return jsonDecode(response.body) as String;
    } catch (e) {
      throw Exception("Erro ao deletar registro! ${e.toString()}");
    }
  }

  Future<bool> update (String id, Task task) async {
    try {
      String json = jsonEncode(task.toJson());
      Response response = await _tasksRepository.update(id, json);
      return response.statusCode == 200;
      //return jsonDecode(response.body) as String;
    } catch (e) {
      throw Exception("Erro ao atualizar registro! ${e.toString()}");
    }
  }

  Future<Task?> show(String id) async {
    try {
      Response response = await _tasksRepository.show(id);
      //String json = jsonEncode(response.body);
      if (response.statusCode == 200){
        Map<String, dynamic> json = jsonDecode(response.body);
        return Task.listFromJson(json).first;
      }
      return null;
      //return jsonDecode(response.body) as String;
    } catch (e) {
      throw Exception("Erro ao obter registro! ${e.toString()}");
    }
  }
}