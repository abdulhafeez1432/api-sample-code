import 'package:api_app/model/news_category.dart';
import 'package:api_app/services/connection.dart';
import 'package:flutter/material.dart';

class ListNews extends StatefulWidget {
  ListNews({Key? key}) : super(key: key);

  @override
  _ListNewsState createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  late Future<List<NewsCategory>> fetchResult;
  @override
  void initState() {
    fetchResult = fetchCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsCategory>>(
      future: fetchResult,
      builder: (c, s) {
        if (s.hasData) {
          //List<Tab> tabs = new List<Tab>();
          List<Tab> tabs = <Tab>[];

          for (int i = 0; i < s.data!.length; i++) {
            tabs.add(Tab(
              child: Text(
                s.data![i].name,
                style: TextStyle(color: Colors.white),
              ),
            ));
          }
          return DefaultTabController(
            length: s.data!.length,
            child: Scaffold(
              appBar: AppBar(
                title: Image.asset('assets/logo.png', fit: BoxFit.cover),
                backgroundColor: Colors.grey[900],
                bottom: TabBar(
                  isScrollable: true,
                  tabs: tabs,
                ),
              ),
            ),
          );
        }
        if (s.hasError) print(s.error.toString());
        return Scaffold(
          body: Center(
              child: Text(s.hasError ? s.error.toString() : "Loading...")),
        );
      },
    );
  }
}
