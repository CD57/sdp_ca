import 'package:flutter/material.dart';

class UserInputForm extends StatelessWidget {
  final Function(String) onSaved;
  final String initValue;
  final String regex;
  final String hint;
  final bool hidden;

  const UserInputForm(
      {Key? key,
      required this.onSaved,
      required this.initValue,
      required this.regex,
      required this.hint,
      required this.hidden})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initValue,
      onSaved: (_value) => onSaved(_value!),
      obscureText: hidden,
      validator: (_value) {
        return RegExp(regex).hasMatch(_value!)
            ? null
            : 'Invalid Input, Please Try Again';
      },
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        hintText: hint,
      ),
    );
  }
}
