import 'package:flutter/material.dart';
import 'package:project_2/pages/choose_location.dart';
import 'package:project_2/pages/home.dart';
import 'package:project_2/pages/loading.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    }
));