import 'package:api_app/model/post.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({Key? key, required this.post}) : super(key: key);
  final Post post;

  //const NewsDetail({Key? key}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: Container(
        child: Text("Welcome"),
      ),
    );
  }
}
