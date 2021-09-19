import 'package:api_app/model/author.dart';
import 'package:api_app/services/connection.dart';
import 'package:flutter/material.dart';

class AddAuthor extends StatefulWidget {
  const AddAuthor({Key? key}) : super(key: key);

  @override
  _AddAuthorState createState() => _AddAuthorState();
}

class _AddAuthorState extends State<AddAuthor> {
  //final TextEditingController _controller = TextEditingController();
  final TextEditingController nameControler = new TextEditingController();
  final TextEditingController addressControler = new TextEditingController();

  Future<Author>? _futureAuthor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Author"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futureAuthor == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: nameControler,
          decoration: const InputDecoration(hintText: 'Enter FullName'),
        ),
        TextField(
          controller: addressControler,
          decoration: const InputDecoration(hintText: 'Enter address'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAuthor =
                  createAuthor(nameControler.text, addressControler.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Author> buildFutureBuilder() {
    return FutureBuilder<Author>(
      future: _futureAuthor,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //return Text(snapshot.data!.name);
          print("Hello World");
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
