// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/tasks_provider.dart';
import '../services/tasks_service.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key, required this.task});

  final Task task;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {


  
  
  var _titleController = TextEditingController();
  var _locationController = TextEditingController();
  
  DateTime? selectedDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2999))
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selectedDate = value;
      });
      print(selectedDate);
    });
  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.task.title;

  _locationController.text = widget.task.location.toString();
  selectedDate = widget.task.date;
  }
  
  
  @override
  Widget build(BuildContext context) {

    final tasks = Provider.of<TaskProvider>(context);

    void _submitData(String id) {

    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || selectedDate == null) {
      return;
    }
    
    Task tr = Task(id: id, title: enteredTitle, date: selectedDate!); //service.show(id) as Task;
    tr.location = _locationController.text;

    // TasksService service = TasksService();
    // service.update(tr.id, tr);

    tasks.editTask(tr.id!, tr);
    Navigator.of(context).pop();
  }


    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              controller: _titleController,
              //onSubmitted: (_) => _submitData(),
            ),
            
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      child: Text(selectedDate == null
                          ? 'Data Vazia!'
                          : DateFormat('dd/MM/yyyy').format(selectedDate!))),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: Icon(Icons.calendar_today),
                    style: ButtonStyle(
                        iconColor: MaterialStatePropertyAll(
                            Theme.of(context).textTheme.labelLarge!.color),
                        foregroundColor: MaterialStatePropertyAll(
                            Theme.of(context).textTheme.labelLarge!.color)),
                  ),
                ],
              ),
            ),
            

            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Localização'),
                      controller: _locationController,
                      //onSubmitted: (_) => _submitData(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: () => _submitData(widget.task.id!),
              child: Text('+'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}