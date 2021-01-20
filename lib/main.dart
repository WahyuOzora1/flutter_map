import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter/services.dart';
import 'package:android_intent/android_intent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;
  final LatLng latlongJakarta = const LatLng(-6.121435, 106.774124);

  //deklarasi maptytpe
  MapType _currentTypeMap = MapType.normal;

  void _mapTypePressed() {
    if (_currentTypeMap == MapType.normal) {
      _currentTypeMap == MapType.satellite;
    } else {
      _currentTypeMap = MapType.normal;
    }
  }

  //menambahkan method ketika marker di klik

  // void _addMarkerMapPressed() {
  //   mapController.addMarker(
  //     MarkerOptions(
  //       position: LatLng(mapController.cameraPosition.target.latitude,
  //           mapController.cameraPosition.target.longitude),
  //       infoWindowText: InfoWindowText('Jakarta', 'Lokasi Jakarta'),
  //       icon: BitmapDescriptor.defaultMarker,
  //     ),
  //   );
  // }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void openLocationSetting() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    await intent.launch();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openLocationSetting();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Apps'),
          backgroundColor: Colors.green,
        ),
        //Menambahkan widget pada bagian atas Maps
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: latlongJakarta, zoom: 11),

              //aktifkan gestures maps
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,

              //untuk mengaktifkan current location
              myLocationEnabled: true,
              //agar bisa di zoom
              zoomGesturesEnabled: true,
              mapType: MapType.satellite, //tipe maps
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                  alignment: Alignment.topLeft, //p
                  child: Column(
                    children: <Widget>[
                      //posisi diatas sebelah kanan
                      FloatingActionButton(
                        onPressed: _mapTypePressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.green,
                        child: const Icon(
                          Icons.map,
                          size: 30.0,
                        ),
                      ),

                      //tambahkan icon untuk menampilkan marker
                      const SizedBox(
                        height: 16.0,
                      ),
                      // FloatingActionButton(
                      //   onPressed: _addMarkerMapPressed,
                      //   materialTapTargetSize: MaterialTapTargetSize.padded,
                      //   backgroundColor: Colors.green,
                      //   child: const Icon(
                      //     Icons.add_location,
                      //     size: 36.0,
                      //   ),
                      // )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
