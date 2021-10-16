import 'package:api_app/model/news_bycategory.dart';
import 'package:api_app/model/post.dart';
import 'package:api_app/services/connection.dart';
import 'package:flutter/material.dart';

import 'news_detail.dart';
class NewsSiteDetails extends StatefulWidget {
  const NewsSiteDetails({Key? key, required this.site}) : super(key: key);

  final Site site;


  @override
  _NewsSiteDetailsState createState() => _NewsSiteDetailsState();
}

class _NewsSiteDetailsState extends State<NewsSiteDetails> {


  bool navBarMode = false;

  List<Post> posts = [];
  String? page;

  bool loading = true;
  String? error;

  Future<void> fetchBySite() async {
    try {
      PostResponse res = await fetchSite(page, widget.site.name);
      print(res);
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


  void initState() {


    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) => fetchBySite());
    //WidgetsBinding.instance!.addPostFrameCallback((_) => fetchSiteList());
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[800],
        title: Text("News from ${widget.site.name}"),

      ),
      body: SingleChildScrollView(
        child: Center(
            child: _buildPostsList(context),
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
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index >= posts.length) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            fetchBySite();
          });

          return Center(
            child: CircularProgressIndicator(),
          );
        }
        Post post = posts[index];
        print(post.title);


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
