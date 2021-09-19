import 'package:api_app/pages/register/register_page.dart';
import 'package:flutter/material.dart';

import 'pages/category/categories.dart';

class NavDrawer extends StatelessWidget {
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

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('couonectechnology.com.ng'),
            accountEmail: Text('ade@couonectechnology.com.ng'),
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
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
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
