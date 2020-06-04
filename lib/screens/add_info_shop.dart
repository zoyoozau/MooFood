import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:moofood/utility/my_style.dart';

class AddInfoShop extends StatefulWidget {
  @override
  _AddInfoShopState createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
// field

  double lat, lng;
  File file;

  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
    });
    print('lat = $lat, lng = $lng');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

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
            lat == null ? MyStyle().showProgrees() : showMap(),
            // showMap(),
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

  Set<Marker> showMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('myshop'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
              title: 'ร้านของฉัน', snippet: 'ละติจูด = $lat, ลองติจูด = $lng')),
    ].toSet();
  }

  Widget showMap() {
    LatLng latLng = LatLng(lat, lng);
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
        markers: showMarker(),
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
                onPressed: () => chooseImage(ImageSource.camera)),
            Container(
              width: 200.0,
              child: file == null ? Image.asset('images/image.png') :Image.file(file),
            ),
            IconButton(
                icon: Icon(
                  Icons.add_photo_alternate,
                  size: 36.0,
                ),
                onPressed: () => chooseImage(ImageSource.gallery)),
          ],
        ),
      );

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 512.0,
        maxHeight: 512.0,
      );
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

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
