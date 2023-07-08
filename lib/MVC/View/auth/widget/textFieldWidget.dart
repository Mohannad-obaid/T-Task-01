import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFiledWidget extends StatefulWidget {
  late TextEditingController controller;
  late String hintText;
  late bool isPassword;
  late TextInputType keyboardType;
  late Icon prefixIcon;

  TextFiledWidget({super.key,
    required this.controller,
    required this.hintText,
    required this.isPassword,
    required this.keyboardType,
    required this.prefixIcon,
  });

  @override
  State<TextFiledWidget> createState() => _TextFiledWidgetState();
}

class _TextFiledWidgetState extends State<TextFiledWidget> {


  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? showPassword : !showPassword,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon ,
        suffixIcon: widget.isPassword ? IconButton(
          onPressed: (){
            setState(() {
              showPassword = !showPassword;
            });
          },
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
        ) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onFieldSubmitted: (value) {
        widget.controller.text = value;
        setState(() {
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.hintText}';
        }
        return null;
      },


    );
  }
}
