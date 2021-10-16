import 'package:api_app/model/news_category.dart';
import 'package:api_app/model/news_bycategory.dart';
import 'package:api_app/services/connection.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class AddFavorite extends StatefulWidget {
  const AddFavorite({Key? key}) : super(key: key);

  @override
  _AddFavoriteState createState() => _AddFavoriteState();
}

class _AddFavoriteState extends State<AddFavorite> {
  late Future<List<NewsCategory>> fetchResult;
  late Future<List<Site>> fetchSiteResult;

  @override
  void initState() {
    fetchResult = fetchCategory();
    fetchSiteResult = fetchSites();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Favorite'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 10),
            buildCAtegoryText("Select Category"),
            SizedBox(width: 10),
            buildCategoryUI(context),
            buildCAtegoryText("Select Site"),
            SizedBox(width: 10),
            buildSiteUI(context),
          ],
        ),
      ),
    );
  }

  buildCategoryUI(BuildContext context) {
    return FutureBuilder<List<NewsCategory>>(
        future: fetchResult,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      snapshot.data![index].isSelected = true;
                      print("Hello World");
                    });
                  },
                  child: Container(
                    color: snapshot.data![index].isSelected
                        ? Colors.green[600]
                        : Colors.white,
                    child: ListTile(
                      title: Text(snapshot.data![index].name),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  buildSiteUI(BuildContext context) {
    return FutureBuilder<List<Site>>(
        future: fetchSiteResult,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      snapshot.data![index].isSelected = true;
                      print("Hello World");
                    });
                  },
                  child: Container(
                    color: snapshot.data![index].isSelected
                        ? Colors.red[100]
                        : Colors.white,
                    child: ListTile(
                      title: Text(snapshot.data![index].name),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  Align buildCAtegoryText(String heading) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 19.0),
        child: Row(
          children: [
            Text(heading, style: kNonActiveTabStyle),
            SizedBox(width: 10),
            SizedBox(height: 50),
            //Icon(Icons.backup_table_sharp),
          ],
        ),
      ),
    );
  }
}
