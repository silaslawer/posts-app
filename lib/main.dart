import 'package:flutter/material.dart';
import 'package:random_user/app.dart';
import 'package:random_user/services/serviceLocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  runApp(PostApp());
}