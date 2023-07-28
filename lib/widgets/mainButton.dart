/*

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatelessWidget {
  late String txt;
 late Function() ontap;

  MainButton({
    required this.txt, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap:ontap ,
      child: Container(
        decoration:BoxDecoration(color:Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(14) ,
        
        ) ,
        alignment:Alignment.center ,
        
        height: 66.h,
        width:size.width  ,  
        child: Center(
          child: Text(txt,
          style:TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight:FontWeight.w600,
    
          ) ,
          ),
        ),
      ),
    );
  }
}
*/