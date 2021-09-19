import 'package:flutter/material.dart';

import 'pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'All NewsPaper Application',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors
            .pink[700], //Changing this will change the color of the TabBar
        accentColor: Colors.cyan[600],
      ),
      //home: LoginPage(),
      home: HomePage(),
    );
  }
}
