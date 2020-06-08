import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moofood/model/user_modle.dart';
import 'package:moofood/screens/add_info_shop.dart';
import 'package:moofood/screens/edit_info_shop.dart';
import 'package:moofood/utility/my_constant.dart';
import 'package:moofood/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfomationShop extends StatefulWidget {
  @override
  _InfomationShopState createState() => _InfomationShopState();
}

class _InfomationShopState extends State<InfomationShop> {
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    readDataUser();
  }

  Future<Null> readDataUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('id');
    String url =
        '${MyConstant().domain}/moofood/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(url).then((value) {
      // print('value = $value');
      var result = json.decode(value.data);
      // print('result =$result');
      for (var map in result) {
        setState(() {
          userModel = UserModel.fromJson(map);
        });
        print('nameshop = ${userModel.nameShop}');
      }
    });
  }

  void routeInfoshop() {

    Widget widget = userModel.nameShop.isEmpty ? AddInfoShop() : EditInfoShop() ;
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.push(context, materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        userModel == null
            ? MyStyle().showProgrees()
            : userModel.nameShop.isEmpty
                ? showNoData(context)
                : showListInfoShop(),
        addAndEditButton(),
      ],
    );
  }

  Widget showListInfoShop() => SingleChildScrollView(
    child: Column(
      children: <Widget>[
        MyStyle().mySizebox(),
        MyStyle().showTitle('ชื่อร้าน : ${userModel.nameShop}'),
        MyStyle().mySizebox(),
        showImage(),
        MyStyle().mySizebox(),
        Row(
          children: <Widget>[
            MyStyle().showTitle('ที่อยู่ของร้าน'),
          ],
        ),
        Row(
          children: <Widget>[
            Text('${userModel.address}'),
          ],
        ),
        MyStyle().mySizebox(),
        showMap(),
      ],
    ),
  );

  Widget showImage() => Container(
        height: 300.0,
        width: 400.0,
        child: Image.network('${MyConstant().domain}${userModel.urlPicture}'),
      );

  Set<Marker> showMark() {
    return <Marker>[
      Marker(
        infoWindow: InfoWindow(
            title: 'ตำแหน่งร้าน',
            snippet:
                'ละติจุด = ${userModel.lat} , ลองติจูด = ${userModel.lng}'),
        markerId: MarkerId('shopID'),
        position: LatLng(
          double.parse(userModel.lat),
          double.parse(userModel.lng),
        ),
      )
    ].toSet();
  }

  Widget showMap() {
    double lat = double.parse(userModel.lat);
    double lng = double.parse(userModel.lng);

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      child: GoogleMap(
        initialCameraPosition: position,
        onMapCreated: (controller) {},
        mapType: MapType.normal,
        markers: showMark(),
      ),
      padding: EdgeInsets.all(10.0),
      height: 300.0,
    );
  }

  Widget showNoData(BuildContext context) =>
      MyStyle().titleCenter(context, 'ยังไม่มีข้อมูล กรุณาเพิ่มข้อมูลด้วยคะ');

  Row addAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                onPressed: () => routeInfoshop(),
                child: Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
