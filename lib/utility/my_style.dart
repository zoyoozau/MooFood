import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.blue.shade900;
  Color primaryColor = Colors.cyan;

  Widget showProgrees(){
    return Center(child: CircularProgressIndicator(),);
  }

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 24.0,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 18.0,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold),
      );

  Container showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/moodriv.png'),
    );
  }

  BoxDecoration myBox(String namePic) {
    return BoxDecoration(
      image: DecorationImage(
          image: AssetImage('images/$namePic'), fit: BoxFit.cover),
    );
  }

  Widget titleCenter(BuildContext context, String string) {
    return Center(
      child: Container(width: MediaQuery.of(context).size.width*0.7,
        child: Text(
          string,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  MyStyle();
}
