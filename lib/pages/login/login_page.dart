import 'package:api_app/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_service.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? username, password;

  bool isLoading = false;

  String? requiredValidator(String? text) {
    if (text?.isEmpty ?? true) return 'Required';
    return null;
  }

  void submit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    setState(() {
      isLoading = true;
    });

    try {
      String token = await AuthService().login(
        username: username!,
        password: password!,
      );
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.setString('token', token);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
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

  void toRegister() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('Login')),
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
                  ElevatedButton(onPressed: submit, child: Text('Login')),
                  TextButton(onPressed: toRegister, child: Text('Register Now'))
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
