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
  bool loading = true;
  String? error;

  void fetchNewsByCategory() async {
    try {
      final res = await getNewsByCategory(widget.category.name);

      ///this is feteching data from list of post from
      ///http://api.allnigerianewspapers.com.ng/api/allnewsbycategory/{category}
      ///{category} = wideget.category.name

      /// do what you need with the res like saving in the list of posts category_details.dart and news_bycategories.dart
      print(res.category.id);

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

    WidgetsBinding.instance!.addPostFrameCallback((_) => fetchNewsByCategory());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
