import 'package:flutter/material.dart';
import 'package:moofood/utility/my_style.dart';
import 'package:moofood/utility/singout_process.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

String nameUser;

class _MainUserState extends State<MainUser> {
  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('Name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text(nameUser == null ? 'Main User' : '$nameUser Login'),
        // actions: signOut(context),
      ),
    );
  }

  Drawer showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showDrawerHeader(),
          signOutMenu(),
        ],
      ),
    );
  }

  UserAccountsDrawerHeader showDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBox('user.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('$nameUser'),
      accountEmail: Text('fu'),
    );
  }

  ListTile signOutMenu() {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Sign Out'),
      onTap: () => singOutProcess(context)
      ,
    );
  }

  // List<Widget> signOut(BuildContext context) {
  //   return <Widget>[
  //     IconButton(
  //         icon: Icon(Icons.exit_to_app),
  //         onPressed: () => singOutProcess(context)),
  //   ];
  // }
}