import 'package:flutter/material.dart';
import 'package:moofood/screens/main_rider.dart';
import 'package:moofood/screens/main_shop.dart';
import 'package:moofood/screens/main_user.dart';
import 'package:moofood/screens/signin.dart';
import 'package:moofood/screens/signup.dart';
import 'package:moofood/utility/my_style.dart';
import 'package:moofood/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkPreferance();
  }

  Future<Null> checkPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String chooseType = preferences.getString('ChooseType');
      if (chooseType != null || chooseType.isNotEmpty) {
        if (chooseType == 'User') {
          routeToService(MainUser());
        } else if (chooseType == 'Shop') {
          routeToService(MainShop());
        } else if (chooseType == 'Rider') {
          routeToService(MainRider());
        }
      } else {
        noramlDialog(context, 'Error User Type');
      }
    } catch (e) {}
  }

  void routeToService(
    Widget myWidget,
  ) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: showDarwer(),
    );
  }

  Drawer showDarwer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHeadDarwer(),
            signinMenu(),
            signupMenu(),
          ],
        ),
      );

  ListTile signinMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sign In'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  ListTile signupMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sign Up'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignUp());
        Navigator.push(context, route);
      },
    );
  }

  UserAccountsDrawerHeader showHeadDarwer() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().myBox('guest.jpg'),
        currentAccountPicture: MyStyle().showLogo(),
        accountName: Text('Guest'),
        accountEmail: Text('Please Login'));
  }
}
