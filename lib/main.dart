import 'package:api_app/add_author.dart';
import 'package:api_app/drawer.dart';
import 'package:api_app/search.dart';
import 'package:api_app/services/connection.dart';
import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

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

  List<Post> posts = [];
  String? page;

  bool loading = true;
  String? error;

  Future<void> fetchPosts() async {
    try {
      PostResponse res = await getNews(page);

      posts.addAll(res.posts);
      page = res.nextUrl;

      loading = false;
    } catch (e) {
      loading = false;
      error = e.toString();
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) => fetchPosts());
  }

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
          child: _buildPostsList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddAuthor()),
              );
            }),
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

  Widget _buildPostsList() {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Text(error!);
    }
    return ListView.builder(
      itemCount: posts.length + 1,
      itemBuilder: (context, index) {
        if (index >= posts.length) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            fetchPosts();
          });

          return Center(
            child: CircularProgressIndicator(),
          );
        }
        Post post = posts[index];
        print(post.title);
        return Text(post.title);
      },
    );
  }
}
