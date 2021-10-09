import 'package:api_app/model/news_bycategory.dart';
import 'package:api_app/model/news_category.dart';
import 'package:api_app/services/connection.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({Key? key, required this.category}) : super(key: key);

  final NewsCategory category;

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  late Future<List<NewsByCategory>> fetchResult;

  @override
  void initState() {
    fetchResult = getNewsByCategory(widget.category.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All News On the category"),
      ),
      body: Center(
        child: FutureBuilder<List<NewsByCategory>>(
          future: fetchResult,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  print(snapshot.data![index].title);
                  //print(snapshot.data![index]);
                  return Text(snapshot.data![index].title);
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildPostsList(List<NewsByCategory> news) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: news.length,
      itemBuilder: (context, index) {
        NewsByCategory post = news[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.content, maxLines: 1),
        );
      },
    );
  }
}
