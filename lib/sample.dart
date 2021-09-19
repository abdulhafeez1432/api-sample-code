import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import '../../drawer.dart';
import '../../model/post.dart';
import '../../search.dart';
import '../../services/connection.dart';
import '../add_author/add_author.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('All Nigeria NewsPaper App'),
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
        //child: _myPostList(),
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
        print(post.url);

        return Container(
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.height * 0.15,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(post.url),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    post.title,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FlatButton(
                    onPressed: () {
                      print("It is Working Fine");
                    },
                    child: Text(post.title),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _myPostList() {
    return Container(
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.height * 0.15,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/space.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "NASA's green propellent\n infusion mission deploys",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                  "NASA's green propellent mission (GPM0 has\nsucessfully launced from EDM"),
            ],
          )
        ],
      ),
    );
  }
}
