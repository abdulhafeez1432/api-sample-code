import 'package:api_app/services/connection.dart';
import 'package:flutter/material.dart';

import 'model/post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final url = "https://jsonplaceholder.typicode.com/posts";
  late Future<Post> _newsModel;

  @override
  void initState() {
    _newsModel = getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Fetch Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('News App'),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: _newsModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
                print(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
