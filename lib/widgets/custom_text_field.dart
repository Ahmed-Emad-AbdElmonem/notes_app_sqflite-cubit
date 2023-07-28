import 'package:flutter/material.dart';


class CustomFormTextField extends StatefulWidget {
  CustomFormTextField({
    this.hintText,
    this.isPassword = false,
    this.label,
    this.inputType,
    this.controller,
    this.onSubmitted,
    this.onChanged,
    this.textInputAction,
    this.validator,
    this.onTap,
    this.prefixIcon,
  });

  String? hintText;
  String? label;
  TextInputType? inputType;
  ValueChanged<String>? onSubmitted;
  Function(String)? onChanged;
  late bool isPassword;
  TextEditingController? controller;
  TextInputAction? textInputAction;
  String? Function(String?)? validator;
  Function()? onTap;
 Widget? prefixIcon;
  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  bool isHidden = true;
  /*String? hintText;
  String? label;
  TextInputType? inputType;
  ValueChanged<String>? onSubmitted;
  Function(String)? onChanged;
   bool? isPassword;
  TextEditingController? controller;
  TextInputAction? textInputAction;*/

  @override
  Widget build(BuildContext context) {
    return Container(
       
      child: Column(
        children: [
          TextFormField(
            
            onTap:widget.onTap ,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            controller: widget.controller,
            style: TextStyle(color: Colors.black, fontSize: 17 ),
            keyboardType: widget.inputType,
            validator: widget.validator,
            decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14 ,
                ),
                prefixIcon: widget.prefixIcon,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                suffixIconConstraints: BoxConstraints(
                  maxHeight: 20 ,
                )),
                
          ),
        ],
      ),
    );
  }
}
