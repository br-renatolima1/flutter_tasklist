
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:task_list/models/task.dart';

import '../providers/tasks_provider.dart';
import '../services/tasks_service.dart';

class NewTask extends StatefulWidget {
  //final Function addTx;

  //NewTask(this.addTx);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? selectedDate;

  Future<String> getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) Future.value("");
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) Future.value("");
    }
    //location.enableBackgroundMode(enable: true);
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _locationController.text =
            "${currentLocation.latitude} : ${currentLocation.longitude}";
      });
    });

    _locationData = await location.getLocation();
    return "${_locationData.latitude} : ${_locationData.longitude}";
  }

  
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

      if (kDebugMode) {
        print(selectedDate);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation().then((location) => {
          setState(() {
            _locationController.text = location;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    
    final tasks = Provider.of<TaskProvider>(context);

    void _submitData() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || selectedDate == null) {
      return;
    }

    Task task = Task(
        id: DateTime.now().toString(),
        title: enteredTitle,
        date: selectedDate!);
    task.location = _locationController.text;
    // TasksService service = TasksService();
    // service.insert(task);
    //
    tasks.addTask(task);    
    Navigator.of(context).pop();
  }


    
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10, 
            bottom: mediaQuery.viewInsets.bottom + 10, 
            left: 10, 
            right: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Título'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // } ,
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
                        onSubmitted: (_) => _submitData(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _submitData(),
                child: Text('+'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
