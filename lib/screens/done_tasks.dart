import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_sqflite/layout_cubit/cubit.dart';
import 'package:notes_app_sqflite/layout_cubit/states.dart';
import 'package:notes_app_sqflite/widgets/item_builder.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=  BlocProvider.of<AppCubit>(context);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        var tasks = cubit.doneTasks;
        return
       tasks.length <= 0
            ? const Center(
                child: Text(
                'please add some tasks',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ))
            :
         ListView.separated(
        itemCount:tasks.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.grey,);
        },
        itemBuilder: (BuildContext context, int index) {
          return buildTaskItem(tasks[index],context);
        },
      );
      },
       
    );
  }
}