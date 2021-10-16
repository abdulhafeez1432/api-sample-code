import 'package:api_app/constants.dart';
import 'package:api_app/model/news.dart';
import 'package:api_app/model/news_bycategory.dart';
import 'package:api_app/model/news_category.dart';
import 'package:api_app/pages/details/news_detail.dart';
import 'package:api_app/pages/details/news_sitedetails.dart';
import 'package:api_app/pages/favorite/add_favorite.dart';
import 'package:api_app/pages/video/video.dart';
import 'package:api_app/views/read_news_view.dart';
import 'package:api_app/widgets/app_bottom_navigation.dart';
import 'package:api_app/widgets/primary_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/painting.dart' as painting;
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


  void toRefresh() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }





  late Future<List<NewsCategory>> fetchResult;
  late Future<List<Site>> fetchSiteResult;

  bool navBarMode = false;

  List<Post> posts = [];
  String? page;

  bool loading = true;
  String? error;

  Future<void> fetchPosts() async {
    try {
      PostResponse res = await getNews(page);
      // fetchSiteResult = await fetchSites();
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
    fetchResult = fetchCategory();
    fetchSiteResult = fetchSites();


    super.initState();

            

    WidgetsBinding.instance!.addPostFrameCallback((_) => fetchPosts());
    //WidgetsBinding.instance!.addPostFrameCallback((_) => fetchSiteList());
  }

  String token = "Default Name";

  takeSharedPreference() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
     
        token = prefs.getString('token') ?? "Default Name";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsCategory>>(
      future: fetchResult,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Tab> tabs = <Tab>[];
          for (int i = 0; i < snapshot.data!.length; i++) {
            tabs.add(Tab(text: snapshot.data![i].name.toUpperCase()));
          }
          return buildTabBarController(snapshot, tabs, context, token);
        } else if (snapshot.hasError) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              //Note: You can also changed the preffered height for the appbar
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.green[800],
                //All Constant Text to be moved to a const file
                title: Text('24-7 Nigeria News'),
              ),
              body: Text("${snapshot.error}"));
        }
        return Scaffold(
            resizeToAvoidBottomInset: false,
            //Note: You can also changed the preffered height for the appbar
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.green[800],
              //All Constant Text to be moved to a const file
              title: Text('24-7 Nigeria News'),
            ),
            body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  DefaultTabController buildTabBarController(
      AsyncSnapshot<List<NewsCategory>> snapshot,
      List<Tab> tabs,
      BuildContext context, String token) {

    return DefaultTabController(
      length: snapshot.data!.length,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //Note: You can also changed the preffered height for the appbar
        appBar: buildAppBar(tabs, context),
        drawer: NavDrawer(token: token),
        body: buildMainBody(context),




        //_widgetOptions.elementAt(_selectedIndex);
        //floatingActionButton: buildFloatingActionButton(context),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //For Optimization, you can take this BottomAppBar Widget any other seperate file so that it will be easily trackable
          bottomNavigationBar: AppBottomNavigation(),
      ),
    );
  }

  AppBar buildAppBar(List<Tab> tabs, BuildContext context) {
    return AppBar(
        backgroundColor: Colors.green[800],
      //All Constant Text to be moved to a const file
      centerTitle: true,
      title: Text('24-7 Nigeria News'),
      bottom: PreferredSize(
          child: ColoredBox(
            //All Constant Colors to be moved to a const file
            color: Colors.white,
            child: TabBar(
                labelColor: Colors.black,
                isScrollable: true,
                unselectedLabelColor: Colors.black45.withOpacity(0.3),
                indicatorColor: Colors.green,

                tabs: tabs),
          ),
          preferredSize: Size.fromHeight(30.0)),
      //centerTitle: true,
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
    );
  }







  SingleChildScrollView buildMainBody(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.0),
          buildSiteUI(context),
          buildYourFavoriteNewspaper(),
          //FavoriteUI(context),
          SizedBox(height: 25.0),
          buildTopNigeriaPaperUI(),
          SizedBox(height: 10.0),
          buildTopNigeriaPaperListView(context)
        ],
      ),
    );
  }

  Align buildYourFavoriteNewspaper() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 19.0),
        child: Row(
          children: [
            Text("YOUR FAVORITE NEWSPAPER", style: kNonActiveTabStyle),
            SizedBox(width: 10),
            SizedBox(height: 50),
            //Icon(Icons.backup_table_sharp),
          ],
        ),
      ),
    );
  }

  buildTopNigeriaPaperListView(BuildContext context) {
    return Container(
      child: _buildPostsList(context),
    );
  }

  Align buildTopNigeriaPaperUI() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: EdgeInsets.only(left: 19.0),
          child: Row(
            children: [
              Text("TOP NEWSPAPERS HEADLINES", style: kNonActiveTabStyle),
              SizedBox(width: 10),
              //Icon(Icons.book_online),
            ],
          )),
    );
  }




  FavoriteUI(BuildContext context){
   return FutureBuilder<PostResponse>(
      future: getFavorite(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        if (snapshot.hasData) {
          List<Post> posts = snapshot.data!.posts;

          return ListView.builder(
            itemCount: posts.length,
            scrollDirection: Axis.horizontal,

            itemBuilder: (context, index) {
              //You need not to assign the value to any var. You can just send as PrimaryCard(news: popluarList[index])
              Post post = posts[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetails(post: post),

                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12.0),
                  child:   Container(
                  //You should not give the static width. You can give it from MediaQuery so that it will be responsive in all type of screen size.
                  width: 300.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: kGrey3, width: 1.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 5.0,
                            backgroundColor: kGrey1,
                          ),
                          SizedBox(width: 10.0),
                          Text(post.category.name, style: kCategoryTitle)
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Expanded(
                        child: Hero(
                          tag: post.comment.toString(),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                image: NetworkImage(post.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Move this sizedbox also to a seperate file for easily accessible all over the project
                      SizedBox(height: 5.0),
                      Text(
                        post.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: kTitleCard,
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Text(
                            post.uploaded,
                            style: kDetailContent,
                          ),
                          //You can use Spacer() instead to be nice UI
                          SizedBox(width: 10.0),
                          CircleAvatar(
                            radius: 5.0,
                            backgroundColor: kGrey1,
                          ),
                          SizedBox(width: 10.0),
                          //Text("${post.uploaded} min read", style: kDetailContent)
                          Text("The Data is Working")

                        ],
                      )
                    ],
                  ),
                ),
                ),
              );
            },
          );
        }
        else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  buildSiteUI(BuildContext context) {
    void toSiteDetail(Site site) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => NewsSiteDetails(site: site)));
    }


    return FutureBuilder<List<Site>>(
        future: fetchSiteResult,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                width: double.infinity,
                //You should not use const height. Suggestion: You can use screenHeight
                height: MediaQuery.of(context).size.height * 0.18,
                padding: EdgeInsets.only(left: 18.0),
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            FlatButton(
                              child: CircleAvatar(
                                child: ClipOval(
                                  child: Image.network(
                                    'https://api.allnigerianewspapers.com.ng' +
                                        snapshot.data![index].logo,
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),

                                ),
                              ),
                              onPressed: () {
                                toSiteDetail(snapshot.data![index]);
                              },
                            ),


                            
                          ],
                        ),
                      );
                    }));
          } else if (snapshot.hasError) {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                //Note: You can also changed the preffered height for the appbar
                appBar: AppBar(
                  //All Constant Text to be moved to a const file
                  backgroundColor: Colors.green[800],
                  centerTitle: true,
                  title: Text('24-7 Nigeria News'),
                ),
                body: Text("${snapshot.error}"));
          }
          return Scaffold(
              resizeToAvoidBottomInset: false,
              //Note: You can also changed the preffered height for the appbar
              appBar: AppBar(
                //All Constant Text to be moved to a const file
                backgroundColor: Colors.green[800],
                centerTitle: true,
                title: Text('24-7 Nigeria News'),
              ),
              body: Center(child: CircularProgressIndicator()));
        });
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
      physics: NeverScrollableScrollPhysics(),
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


        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostDetails(post: post)));
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
                    child:FadeInImage.assetNetwork(
                      placeholder: 'assets/circle-loading-animation.gif',
                      image: post.imageUrl,
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
