import 'package:flutter/material.dart';
import 'package:moofood/utility/my_style.dart';
import 'package:moofood/utility/singout_process.dart';

class MainRider extends StatefulWidget {
  @override
  _MainRiderState createState() => _MainRiderState();
}

class _MainRiderState extends State<MainRider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDarwer(),
      appBar: AppBar(
        title: Text('Main Raider'),
        // actions: signOut(context),
      ),
    );
  }

  Drawer showDarwer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          drawerHeader(),
          signMenu(),
        ],
      ),
    );
  }

  ListTile signMenu() {
    return ListTile(leading: Icon(Icons.exit_to_app),
      title: Text('Sign Out'),
      onTap: () => singOutProcess(context),
    );
  }

  UserAccountsDrawerHeader drawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBox('rider.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('RaiderJaaaa'),
      accountEmail: Text('eiei'),
    );
  }

  // List<Widget> signOut(BuildContext context) {
  //   return <Widget>[
  //       IconButton(
  //           icon: Icon(Icons.exit_to_app),
  //           onPressed: () => singOutProcess(context))
  //     ];
  // }
}
