import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:moofood/model/user_modle.dart';
import 'package:moofood/utility/my_constant.dart';
import 'package:moofood/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditInfoShop extends StatefulWidget {
  @override
  _EditInfoShopState createState() => _EditInfoShopState();
}

class _EditInfoShopState extends State<EditInfoShop> {
  UserModel userModel;
  String nameShop, address, phone, urlPicture;
  Location location = Location();
  double lat, lng;

  @override
  void initState() {
    super.initState();
    readCurrenInfo();

    location.onLocationChanged.listen((event) {
      setState(() {
        lat = event.latitude;
        lng = event.longitude;
      });
      print('lat = $lat, lng = $lng');
    });
  }

  Future<Null> readCurrenInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String idShop = sharedPreferences.getString('id');
    // print('IDShop = $idShop');

    String url =
        '${MyConstant().domain}/moofood/getUserWhereId.php?isAdd=true&id=$idShop';

// api เรียกค่า json จาก url
    Response response = await Dio().get(url);
    // print('response = $response');

// เปลี่ยน json เป็นภาษาไทย
    var result = json.decode(response.data);
    print('result ==>> $result');

// เอา array ออกจาก json
    for (var map in result) {
      // print('map==>> $map');
      setState(() {
        userModel = UserModel.fromJson(map);
        nameShop = userModel.nameShop;
        address = userModel.address;
        phone = userModel.phone;
        urlPicture = userModel.urlPicture;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userModel == null ? MyStyle().showProgrees() : showContent(),
      appBar: AppBar(
        title: Text('ปรับปรุงรายละเอียด'),
      ),
    );
  }

// ปุ่มแก้ไขข้อมูล โดยใช้ api TextFormField จะมี initialValue:

  Widget showContent() => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            nameShopForm(),
            imageForm(),
            addressShopForm(),
            phoneShopForm(),
            showMap(),
            editButton(),
          ],
        ),
      );

  Widget editButton() => Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(textColor: Colors.white,
        onPressed: () {},
        icon: Icon(Icons.edit),
        label: Text('แก้ไขลายระเอียด'),
        color: MyStyle().primaryColor,
      ));

  Set<Marker> markCurren() {
    return <Marker>[
      Marker(
        markerId: MarkerId('markID01'),
        position: LatLng(lat, lng),
      )
    ].toSet();
  }

  Container showMap() {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 16.0,
    );

    return Container(
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        markers: markCurren(),
      ),
      height: 250.0,
      margin: EdgeInsets.only(top: 16.0),
    );
  }

  Widget imageForm() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: null,
            iconSize: 36.0,
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            height: 200.0,
            child: Image.network('${MyConstant().domain}$urlPicture'),
          ),
          IconButton(
            icon: Icon(Icons.image),
            onPressed: null,
            iconSize: 36.0,
          ),
        ],
      );

  Widget nameShopForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 10.0),
              width: 250.0,
              child: TextFormField(
                onChanged: (value) => nameShop = value,
                initialValue: nameShop,
                decoration: InputDecoration(
                  labelText: 'ชื่อร้าน',
                  border: OutlineInputBorder(),
                ),
              )),
        ],
      );

  Widget phoneShopForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 10.0),
              width: 250.0,
              child: TextFormField(
                onChanged: (value) => phone = value,
                initialValue: phone,
                decoration: InputDecoration(
                  labelText: 'ชื่อร้าน',
                  border: OutlineInputBorder(),
                ),
              )),
        ],
      );

  Widget addressShopForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 10.0),
              width: 250.0,
              child: TextFormField(
                onChanged: (value) => address = value,
                initialValue: address,
                decoration: InputDecoration(
                  labelText: 'ชื่อร้าน',
                  border: OutlineInputBorder(),
                ),
              )),
        ],
      );
}
