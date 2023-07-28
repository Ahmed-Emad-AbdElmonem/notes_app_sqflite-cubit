import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_sqflite/components.dart';
import 'package:notes_app_sqflite/home_layout.dart';
import 'package:notes_app_sqflite/layout_cubit/cubit.dart';

void main()async {
   
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home:BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
        child: HomeLayout()),
    );
  }
}
