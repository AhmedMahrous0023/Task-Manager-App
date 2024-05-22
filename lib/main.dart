import 'package:flutter/material.dart';
import 'package:task_manager_app/Core/My%20Offline%20DataBase/database_helper.dart';
import 'package:task_manager_app/Core/Services/auth_provider_service.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/Core/Services/tasks_provider_service.dart';
import 'package:task_manager_app/Views/Screens/Auth/auth_gate.dart';
import 'package:task_manager_app/Views/Screens/Settings/settings_provider.dart';
import 'package:task_manager_app/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await DatabaseHelper().initDb();


  runApp(
    MultiProvider( 
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
          create: (context) => SettingsProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>( 
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<TasksProvider>(
          create: ((context) => TasksProvider()),),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
final settingsProvider = Provider.of<SettingsProvider>(context);
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskManager App',
      theme: ThemeData(
        primaryColor: firstColor,
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.dark,
      ),
      themeMode: settingsProvider.themeMode,
      home: const AuthGate()
    );
  }
}
