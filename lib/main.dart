import 'package:api_app/drawer.dart';
import 'package:api_app/search.dart';
import 'package:api_app/services/connection.dart';
import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import 'add_author.dart';
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
  @override
  void initState() {
    super.initState();
  }

  final List<TitledNavigationBarItem> items = [
    TitledNavigationBarItem(title: Text('Home'), icon: Icon(Icons.home)),
    TitledNavigationBarItem(title: Text('Search'), icon: Icon(Icons.search)),
    TitledNavigationBarItem(title: Text('Bag'), icon: Icon(Icons.card_travel)),
    TitledNavigationBarItem(
        title: Text('Orders'), icon: Icon(Icons.shopping_cart)),
    TitledNavigationBarItem(
        title: Text('Profile'), icon: Icon(Icons.person_outline)),
  ];

  bool navBarMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'New Fetch Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('News App'),
          centerTitle: true,
          actions: [
            // Navigate to the Search Screen
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                icon: Icon(Icons.search))
          ],
        ),
        drawer: NavDrawer(),
        body: Center(
          child: FutureBuilder<PostResponse>(
            future: getNews(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              if (snapshot.hasData) {
                List<Post> posts = snapshot.data!.posts;

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    Post post = posts[index];
                    print(post.title);
                    return Text(post.title);
                  },
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddAuthor()),
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: TitledBottomNavigationBar(
          height: 60,
          indicatorHeight: 2,
          onTap: (index) => print("Selected Index: $index"),
          reverse: navBarMode,
          curve: Curves.easeInBack,
          items: items,
          activeColor: Colors.red,
          inactiveColor: Colors.blueGrey,
        ),
      ),
    );
  }
}
