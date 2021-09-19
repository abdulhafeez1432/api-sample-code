import 'package:flutter/material.dart';

import '../../model/user.dart';
import '../../services/auth_service.dart';
import '../home/home_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? username, email, password;

  bool isLoading = false;

  String? requiredValidator(String? text) {
    if (text?.isEmpty ?? true) return 'Required';
    return null;
  }

  String? emailValidator(String? text) {
    if (text?.isEmpty ?? true) return 'Required';

    final emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!emailRegex.hasMatch(text!)) {
      return 'Enter a valid email';
    }

    return null;
  }

  void submit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    User user = User.register(
      username: username!,
      password: password,
      email: email!,
    );

    setState(() {
      isLoading = true;
    });

    try {
      User newUser = await AuthService().register(user);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomePage()),
        (_) => false,
      );
    } catch (e) {
      String error = 'Something went wrong';
      if (e is RegisterError) {
        /// handle the custom error from the api
        error = 'some registration error';
      }

      ScaffoldMessenger.of(scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(error)));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('Register')),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: Center(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                children: [
                  TextFormField(
                    // every time we type on the field if it return a string the field shows that string as a error if it is null then everything is fine
                    validator: requiredValidator,
                    // this will ve triggered when we call [formKey.currentState!.save()]
                    onSaved: (value) => username = value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: emailValidator,
                    onSaved: (value) => email = value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: requiredValidator,
                    onSaved: (value) => password = value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(onPressed: submit, child: Text('Register'))
                ],
              ),
            ),
          ),
          if (isLoading) _buildLoading()
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
