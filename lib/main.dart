import 'dart:io';

import 'package:api_app/pages/login/login_page.dart';
import 'package:api_app/services/sputils.dart';
import 'package:flutter/material.dart';

import 'pages/home/home_page.dart';

void main() {

  //This should be used while in development mode, do NOT do this when you want to release to production, the aim of this answer is to make the development a bit easier for you, for production, you need to fix your certificate issue and use it properly, look at the other answers for this as it might be helpful for your case.
  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //All Constant Text to be moved to a const file
      title: 'All NewsPaper Application',
      //Add the primary theme that you want in the overall application

    //  home: LoginPage(),
     home: HomePage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
