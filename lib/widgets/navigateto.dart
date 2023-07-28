import 'package:flutter/material.dart';





void  navigateandfinish(BuildContext context,String stringWidget, [yourdiet]){
 Navigator.pushReplacementNamed(context , stringWidget);
  /* Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));*/
  }

void  navigateto(BuildContext context,Widget widget){
 
 Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
  }



//////////

  void  navigateandfinishing(BuildContext context,String stringWidget,){
 Navigator.pushNamedAndRemoveUntil(context, stringWidget, (route) => false);
  
  }

