import 'package:api_app/pages/favorite/add_favorite.dart';
import 'package:api_app/pages/login/login_page.dart';
import 'package:api_app/pages/register/register_page.dart';
import 'package:api_app/sample.dart';
import 'package:api_app/services/sputils.dart';
import 'package:flutter/material.dart';

import 'pages/category/categories.dart';

class NavDrawer extends StatelessWidget {
  final String token;
  const NavDrawer({required this.token});
  @override
  Widget build(BuildContext context) {
    void toRegister() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => RegisterPage()));
    }

    void toCategory() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => AllCategory()));
    }

    void toFavorite() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => AddFavorite()));
    }



    void toNewCategory() {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginPage()));
    }
    String userName = SPUtil.getString('userName');
    String email = SPUtil.getString('email');
    String token = SPUtil.getString('token');
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName.isEmpty ? 'All News' : userName),
            accountEmail: Text(email.isEmpty ? 'user@allnigerianews.com.ng': email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Category'),
            onTap: toCategory,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Register'),
            onTap: toRegister,
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Login'),
            onTap: toNewCategory,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite'),
            onTap: toFavorite,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
