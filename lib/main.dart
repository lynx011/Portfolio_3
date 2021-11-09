import 'package:flutter/material.dart';
import 'package:pokemon/pages/home_page.dart';

void main(){
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.teal),
  ));
}