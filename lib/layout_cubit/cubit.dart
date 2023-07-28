import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_sqflite/components.dart';
import 'package:notes_app_sqflite/layout_cubit/states.dart';
import 'package:notes_app_sqflite/screens/archieved_tasks.dart';
import 'package:notes_app_sqflite/screens/done_tasks.dart';
import 'package:notes_app_sqflite/screens/new_tasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  int currentIndex = 0;
  List<Widget> screens = [
  const  NewTasksScreen(),
  const  DoneTasksScreen(),
  const  ArchievedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archieved Tasks',
  ];

  void changeNavBarIndex(int index) {
    currentIndex = index;
    emit(AppBarNavChangeStates());
  }

  // database

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() async {
    // مسار تخزين الداتابيز
    String dbPath = await getDatabasesPath();

    // اختيار اسم الداتابيز ودمج المسار مع اسم الداتابيز
    // عند إنشاء الداتابيز
    String path = join(dbPath, 'tasks.db');
    //deleteDatabase(path);
    openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
 CREATE TABLE tasks (id INTEGER PRIMARY KEY, 
   title TEXT, date TEXT, time TEXT, status TEXT, value INTEGER, num REAL''');
      },
      onOpen: (db)  {
         getDataFromDatabase(db);
      },
    ).then((value) {
      database = value;
      emit(AppCreatdATABASEStates());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        emit(AppInsertdATABASEStates());

        getDataFromDatabase(database);
      }).catchError((onError) {});
    });
  }

  void  getDataFromDatabase(
      Database database) async {
        newTasks=[];
        doneTasks=[];
        archivedTasks=[];
    emit(AppgetdATABASELoadingStates());
     database.rawQuery("SELECT * FROM tasks").then((value) {
          
          value.forEach((element) {
            if (element['status']=='new') {
              newTasks.add(element);
            }else if (element['status']=='done'){
              doneTasks.add(element);
            }else{
              archivedTasks.add(element);
            }
          },);
          emit(AppgetdATABASEStates());
        });
  }

/*  Future deleteDatabase(var path) async {
    String dbPath = await getDatabasesPath();
    path = join(dbPath, 'tasks.db');
    await deleteDatabase(path);
  }
*/


// عندى مشكلة هنا
  void updateData({
    required String status,
    required int id,
  }){
          database.rawUpdate(
    'UPDATE tasks SET status = ? WHERE id = ?',
    ['$status', id]).then((value) {
      getDataFromDatabase(database);
        emit(AppUpdatedATABASEStates());
    });
  }


  void  deleteData({
     
    required int id,
  }){
          database.rawDelete
    ('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
        emit(AppDeletedATABASEStates());
    });
  }




  bool isBottomSheetShown = false;

  IconData iconFab = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    iconFab = icon;
  emit(AppChangeBottomSheettates());
  }}