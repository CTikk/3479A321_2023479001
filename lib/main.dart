import 'dart:io';
import 'package:application_laboratorio/theme/theme.dart';
import 'package:application_laboratorio/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:application_laboratorio/pages/home_page.dart'; // Archivo de la pag principal :)
import 'package:provider/provider.dart';
import 'package:application_laboratorio/provider/app_data.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

var logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Solo para escritorio
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await DatabaseHelper().initializeDatabase();
    runApp(
    ChangeNotifierProvider(
      create: (_) => AppData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = MaterialTheme(ThemeData.light().textTheme);

    return MaterialApp(
      title: "Laboratorio 8",
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(), 
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: "Laboratorio 8"),
    );
  }
}