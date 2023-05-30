
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_list/pages/home.dart';
import 'package:task_list/providers/tasks_provider.dart';


void main() {
  
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => TaskProvider()
          ),
      ],
      builder: (context, child) {
        return MainApp();
      },
      ),
    );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
final tasks = Provider.of<TaskProvider>(context);

    final ThemeData theme = ThemeData(
      //primarySwatch: Colors.purple,
      fontFamily: 'Quicksand',
      appBarTheme: AppBarTheme(titleTextStyle: TextStyle(fontWeight: FontWeight.bold)),
      buttonTheme: ButtonThemeData(colorScheme: ColorScheme.dark()),
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(iconColor: MaterialStatePropertyAll(Color.fromRGBO(205, 67, 17, 0.848))))
      );

    return MaterialApp( 
      title: 'Lista de Tarefas',    
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.amber,
          ),
        ),
        themeMode: ThemeMode.system,
      home: const Home()
    );
  }
}
