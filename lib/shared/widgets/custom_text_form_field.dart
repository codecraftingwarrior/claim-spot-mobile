import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  bool isObscureText;
  String labelText;

  CustomTextFormField({this.isObscureText = false, required this.labelText});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
