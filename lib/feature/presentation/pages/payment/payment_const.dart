import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFE5F4F4);
const Color labelColor = Color(0xFF346969);
const Color buttonColor = Colors.orange;
const Color cardColor = Color(0xFFEBD9D7);

const InputDecoration textFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
  counterText: '',
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: labelColor),
  ),

);

const TextStyle labelStyle = TextStyle(color: Colors.black);