import 'package:flutter/material.dart';
import 'package:moofood/utility/my_style.dart';
import 'package:moofood/utility/singout_process.dart';
import 'package:moofood/widget/infomation_shop.dart';
import 'package:moofood/widget/list_food_menu_shop.dart';
import 'package:moofood/widget/order_list_shop.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  @override
  void initState() {
    super.initState();
  }

// field
  Widget currentWidget = OrderListShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text('Main Shop'),
        // actions: singOut(context),
      ),
      body: currentWidget,
    );
  }

  Drawer showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          drawerHeader(),
          homeMenu(),
          foodMenu(),
          infomationMenu(),
          signOutMenu(),
        ],
      ),
    );
  }

  ListTile homeMenu() => ListTile(
      subtitle: Text('รายการอาหารที่ยังไม่ได้ส่งลูกค้า'),
      title: Text('รายการอาหารที่ลูกค้าสั่ง'),
      leading: Icon(Icons.home),
      onTap: () {
        setState(() {
          currentWidget = OrderListShop();
        });
        Navigator.pop(context);
      });

  ListTile foodMenu() => ListTile(
      subtitle: Text('รายการอาหาร'),
      title: Text('รายการอาหาร ของร้าน'),
      leading: Icon(Icons.fastfood),
      onTap: () {
        setState(() {
          currentWidget = ListFoodMenuShop();
        });
        Navigator.pop(context);
      });

  ListTile infomationMenu() => ListTile(
      subtitle: Text('รายละเอียดของร้านค้า'),
      title: Text('ปรับแต่งรายระเอียดร้านค้า'),
      leading: Icon(Icons.info_outline),
      onTap: () {
        setState(() {
          currentWidget = InfomationShop();
        });
        Navigator.pop(context);
      });

  ListTile signOutMenu() {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      onTap: () => singOutProcess(context),
      title: Text('Sign Out'),
    );
  }

  UserAccountsDrawerHeader drawerHeader() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: MyStyle().showLogo(),
      decoration: MyStyle().myBox('shop.jpg'),
      accountName: Text(
        'Shopppiii',
        style: TextStyle(color: MyStyle().darkColor),
      ),
      accountEmail: Text(
        'eiei',
        style: TextStyle(color: MyStyle().primaryColor),
      ),
    );
  }

  // List<Widget> singOut(BuildContext context) {
  //   return <Widget>[
  //     IconButton(
  //         icon: Icon(Icons.exit_to_app),
  //         onPressed: () => singOutProcess(context))
  //   ];
  // }
}
