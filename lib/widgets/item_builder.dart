
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_sqflite/layout_cubit/cubit.dart';

Widget buildTaskItem(Map<dynamic, dynamic> model,context) {
  var cubit = BlocProvider.of<AppCubit>(context);
  String myStringValue = '${model['id']}';
  return Dismissible(
    
    key: ValueKey (myStringValue),
   
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text("${model['time']}"),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model['title']}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${model['date']}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              cubit.updateData(id:model['id'] ,status:'done');
            },
            icon: const Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              cubit.updateData(id:model['id'] ,status:'archive');
            },
            icon: const Icon(
              Icons.archive,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    ),
     onDismissed: (direction) {
      cubit.deleteData(id: model['id']);}
  );
}
