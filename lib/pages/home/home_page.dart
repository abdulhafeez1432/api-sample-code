import 'package:api_app/pages/details/news_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import '../../drawer.dart';
import '../../model/post.dart';
import '../../search.dart';
import '../../services/connection.dart';

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
    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('All Nigeria NewsPaper App'),
          bottom: PreferredSize(
              child: ColoredBox(
                color: Colors.pinkAccent,
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text('Tab 1'),
                      ),
                      Tab(
                        child: Text('Investment'),
                      ),
                      Tab(
                        child: Text('Your Earning'),
                      ),
                      Tab(
                        child: Text('Current Balance'),
                      ),
                      Tab(
                        child: Text('Tab 5'),
                      ),
                      Tab(
                        child: Text('Tab 6'),
                      )
                    ]),
              ),
              preferredSize: Size.fromHeight(30.0)),
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
          child: _buildPostsList(context),
          //child: _myPostList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
              //Navigator.push(
              //context,
              //MaterialPageRoute(builder: (context) => AddAuthor()),
            }),
        bottomNavigationBar: BottomAppBar(
          //color: Colors.pinkAccent,
          color: Theme.of(context).primaryColor.withAlpha(255),
          shape: CircularNotchedRectangle(),
          elevation: 0, //shape of notch
          notchMargin: 5,
          //onTap: onTabTapped,
          //currentIndex: _currentIndex,
          child: BottomNavigationBar(
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Profile')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostsList(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Text(error!);
    }
    return ListView.builder(
      shrinkWrap: true,
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

        //print(post.title);
        //print(post.category.name);
        //print(post.imageUrl);

        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsDetail(post: post)));
          },
          child: Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: BoxDecoration(
              color: Colors.white24.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.height * 0.15,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: post.imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.red, BlendMode.colorBurn)),
                        ),
                      ),
                      placeholder: (context, url) => LinearProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Wrap(
                      children: [
                        Text(
                          post.title,
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Noticia Text',
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Text(
                                  post.category.name.toLowerCase(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(post.site.name),
                              Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
