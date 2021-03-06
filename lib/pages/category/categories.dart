import 'package:api_app/model/news_category.dart';
import 'package:api_app/pages/category/category_details.dart';
import 'package:api_app/services/connection.dart';
import 'package:flutter/material.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({Key? key}) : super(key: key);

  @override
  _AllCategoryState createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  late Future<List<NewsCategory>> fetchResult;

  @override
  void initState() {
    fetchResult = fetchCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onTapCategory(NewsCategory category) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CategoryDetails(category: category)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("All News Category"),
      ),
      body: Center(
        child: FutureBuilder<List<NewsCategory>>(
          future: fetchResult,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  print(snapshot.data![index].name);
                  print(snapshot.data![index]);
                  final category = snapshot.data![index];
                  return InkWell(
                    child: Text(snapshot.data![index].name),
                    onTap: () {
                      onTapCategory(category);
                    },
                  );
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
}
