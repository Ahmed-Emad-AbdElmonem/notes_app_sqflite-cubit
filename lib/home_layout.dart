import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_sqflite/components.dart';
import 'package:notes_app_sqflite/layout_cubit/cubit.dart';
import 'package:notes_app_sqflite/layout_cubit/states.dart';
import 'package:notes_app_sqflite/widgets/custom_text_field.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});

  var ScaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   var cubit= BlocProvider.of<AppCubit>(context);
    return 
       BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertdATABASEStates) {
            Navigator.pop(context);
            
          }
        },
        builder: (context, state) {
       
          return Scaffold(
            
            key: ScaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: state is AppgetdATABASELoadingStates ? 
                ? const Center(child: CircularProgressIndicator())
                : cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blue,
                child: Icon(cubit.iconFab),
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                     if (formKey.currentState!.validate() ){
                   cubit.insertToDatabase(
                title: titleController.text, 
                time: timeController.text, 
                date: dateController.text,);
                 
              } 
               
               dateController.clear();
                timeController.clear();
                titleController.clear(); 
                
                   /* if (formKey.currentState!.validate()) {
                      insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                      ).then((value) {
                        getDataFromDatabase(database).then((value) {
                          Navigator.pop(context);

                          cubit.isBottomSheetShown = false;
                          cubit.iconFab = Icons.edit;
                          tasks = value;
                          print(tasks[0]['title']);
                        });
                      });
                    }*/
                  } else {
                    ScaffoldKey.currentState
                        ?.showBottomSheet((context) {
                          return Container(
                            
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomFormTextField(
                                      prefixIcon: Icon(Icons.abc),
                                      onTap: () {},
                                      controller: titleController,
                                      
                                      hintText: 'Title',
                                      validator: (String? val) {
                                        if (val!.isEmpty) {
                                          return 'title must be not empty';
                                        }
                                        return null;
                                      },
                                      inputType: TextInputType.text,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomFormTextField(
                                      hintText: 'Time',
                                      prefixIcon: Icon(Icons.punch_clock),
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          if (value == null) {
                                            return null;
                                          } else {
                                            return timeController.text =
                                                value.format(context);
                                          }
                                        });
                                      },
                                      controller: timeController,
                                       
                                      validator: (String? val) {
                                        if (val!.isEmpty) {
                                          return 'time must be not empty';
                                        }
                                        return null;
                                      },
                                      inputType: TextInputType.datetime,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomFormTextField(
                                      hintText: 'Date',
                                      prefixIcon: Icon(Icons.date_range),
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2024-05-03'))
                                            .then((value) {
                                          if (value == null) {
                                            return null;
                                          } else {
                                            return dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value);
                                          }
                                        });
                                      },
                                      controller: dateController,
                                      label: 'Date Time',
                                      validator: (String? val) {
                                        if (val!.isEmpty) {
                                          return 'date must be not empty';
                                        }
                                        return null;
                                      },
                                      inputType: TextInputType.datetime,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                        .closed
                        .then((value) {
                          cubit.changeBottomSheetState(
                            isShow: false, 
                            icon: Icons.edit);
                            dateController.clear();
                timeController.clear();
                titleController.clear(); 
                        });
                     cubit.changeBottomSheetState(
                            isShow: true, 
                            icon: Icons.add);
                  }
                }),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                 cubit.changeNavBarIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.menu,
                      ),
                      label: 'tasks'),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check,
                    ),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive,
                    ),
                    label: 'archived',
                  ),
                ]),
          );
        },
      );
    
  }

  
}

/*

 late Database  database;

  Future creatDataBase() async {
    // مسار تخزين الداتا بيز
    String dbPath = await getDatabasesPath();
    // اختيار اسم الداتابيز فهضيف المسار مع اسم الداتابيز
    // لما اكون عاوز طبعا انشئ الداتابيز
    String path = join(dbPath, 'tasks.db');

    database = await openDatabase(
      path,
      version: 1,
     onCreate: (database, version)async {
     await    database
            .execute('''
 CREATE TABLE tasks (id INTEGER PRIMARY KEY, 
   title TEXT, date TEXT, time TEXT, status TEXT, value INTEGER, num REAL''');
            
      },
      onOpen: (database)async {
      await getDataFromDatabase(database).then((value){
     tasks=value;
      
     setState(() {
       
     });
       });
      },
    );
  }

  Future insertToDataBase({
    required String title,
    required String time,
    required String date,
  }) async {
    //if(database != null)
    await database.transaction((txn) async {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) Values("$title","$time","$date","new")')
          .then((value) {

          })
          .catchError((onError) {

          });
       
    });
  }


  Future<List<Map<String, dynamic>>> getDataFromDatabase(Database database)async{
     
  return await database.rawQuery("SELECT * FROM tasks");
  }

  */
