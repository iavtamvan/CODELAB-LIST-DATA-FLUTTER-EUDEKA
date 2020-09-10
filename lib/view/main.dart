import 'package:codelab_list_data_json/config/config.dart';
import 'package:codelab_list_data_json/view/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MainApp(),
  );
}

class MainApp extends StatelessWidget {
  final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    Config.homeRoute: (BuildContext context) {
      return HomePage();
    },
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: _routes,
      initialRoute: Config.homeRoute,
    );
  }
}