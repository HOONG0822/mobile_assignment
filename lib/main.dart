import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'contact.dart';
import 'dart:math';
import 'contact_card.dart';
import 'add_contact.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
  routes: {
    'add contact': (Context) => AddContact(),
    'home': (Context) => MyApp()
  },
));







