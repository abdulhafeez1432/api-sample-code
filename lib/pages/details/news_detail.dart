import 'package:api_app/constants.dart';
import 'package:api_app/model/post.dart';
import 'package:flutter/material.dart';

class PostDetails extends StatelessWidget {

  final Post post;
  const PostDetails({required this.post});


  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        post.comment.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Icon(
          Icons.account_box_outlined,
          color: Colors.white,
          size: 14.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Text(
              post.title,
              style: TextStyle(color: Colors.white, fontSize: 36.0),
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    post.category.name,
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      post.site.name,
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 1, child: coursePrice),
          ],
        ),
      ],
    );

    final bottomContentText = Text(
      post.content,
      style: descriptionStyle,
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(post.imageUrl),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            topContent,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: bottomContentText,
            ),
            Align(
              child: Container(
                  height: 20.0,
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // First child is enter comment text input
                        TextFormField(
                          controller: commentController,
                          autocorrect: false,
                          decoration: new InputDecoration(
                            labelText: "Add Comment",
                            labelStyle:
                            TextStyle(fontSize: 20.0, color: Colors.white),
                            fillColor: Colors.blue,
                            border: OutlineInputBorder(
                              // borderRadius:
                              //     BorderRadius.all(Radius.zero(5.0)),
                                borderSide:
                                BorderSide(color: Colors.purpleAccent)),
                          ),
                        ),
                        // Second child is button
                        IconButton(
                          icon: Icon(Icons.send),
                          iconSize: 20.0,
                          onPressed: () {},
                        )
                      ]
                  )
              ),
            ),




          ],
        ),
      ),
    );
  }
}

class Status extends StatelessWidget {
  final IconData icon;
  final String total;
  Status({required this.icon, required this.total});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: kGrey2),
        SizedBox(width: 4.0),
        Text(total, style: kDetailContent),
      ],
    );
  }
}
