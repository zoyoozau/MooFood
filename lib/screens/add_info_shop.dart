import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moofood/utility/my_style.dart';

class AddInfoShop extends StatefulWidget {
  @override
  _AddInfoShopState createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyStyle().mySizebox(),
            nameForm(),
            MyStyle().mySizebox(),
            addressForm(),
            MyStyle().mySizebox(),
            phoneForm(),
            MyStyle().mySizebox(),
            imageForm(),
            MyStyle().mySizebox(),
            showMap(),
            MyStyle().mySizebox(),
            saveButton(),
            MyStyle().mySizebox(),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Information Shop'),
      ),
    );
  }

  Widget saveButton() => Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton.icon(
          color: MyStyle().primaryColor,
          onPressed: () {},
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          label: Text(
            'Save Data',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget showMap() {
    LatLng latLng = LatLng(13.319348, 100.935624);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
      ),
    );
  }

  Widget imageForm() => Container(
        margin: EdgeInsets.only(
          left: 35.0,
          right: 35.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  size: 36.0,
                ),
                onPressed: () {}),
            Container(
              width: 200.0,
              child: Image.asset('images/image.png'),
            ),
            IconButton(
                icon: Icon(
                  Icons.add_photo_alternate,
                  size: 36.0,
                ),
                onPressed: () {}),
          ],
        ),
      );

  Row nameForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            decoration: InputDecoration(
              labelText: 'ชื่อร้านค้า',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.account_circle),
            ),
          ),
        ),
      ],
    );
  }

  Row addressForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            decoration: InputDecoration(
              labelText: 'ที่อยู่ร้านค้า',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.home),
            ),
          ),
        ),
      ],
    );
  }

  Row phoneForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'เบอร์โทรร้านค้า',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.call),
            ),
          ),
        ),
      ],
    );
  }
}
