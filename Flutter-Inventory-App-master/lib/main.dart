import 'package:flutter/material.dart';
import 'package:Stock_Manager/app/mainview.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainView()); 
} //=> runApp(MainView());
