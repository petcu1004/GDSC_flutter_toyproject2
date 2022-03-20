import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAP TEST',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> _markers = []; //marker들을 넣을 리스트
  List<Polyline> _line = []; //두 marker 사이에 그릴 선을 넣을 리스트
  bool tf = true;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng _center = LatLng(37.56795, 127.06619);

  static final CameraPosition _start = CameraPosition(
    //프로그램 실행 시 처음으로 보여줄 지도의 좌표
    target: LatLng(37.56795, 127.06619),
    zoom: 14,
  );

  static final CameraPosition _univ = //floating 버튼 클릭 시 이동할 좌표
      CameraPosition(target: LatLng(36.7697899, 126.9317528), zoom: 14);

  @override
  void initState() {
    //초기화
    _checkPermission();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    var mapController = controller;

    final marker = Marker(
        markerId: MarkerId('place_name'),
        position: LatLng(37.56795, 127.06619),
        infoWindow: InfoWindow(title: 'title', snippet: 'address'));

    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      body:
          // GoogleMap(
          //   mapType: MapType.normal,
          //   initialCameraPosition: _start,
          //   onMapCreated: (GoogleMapController controller) {
          //     _controller.complete(controller);
          //   },
          //   myLocationEnabled: true,
          //   myLocationButtonEnabled: true,
          //   markers: _markers.toSet(),
          //   polylines: _line.toSet(),
          //   onTap: (pos) {
          //     addMarks(pos);
          //   },
          // ),
          GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 14.0,
        ),
        markers: markers.values.toSet(),
      ),
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.all(8),
      //   child: Row(
      //     children: [
      //       FloatingActionButton.extended(
      //         onPressed: _goToUniv,
      //         label: Text('University'),
      //         icon: Icon(Icons.school),
      //       ),
      //       SizedBox(
      //         width: 10,
      //       ),
      //       FloatingActionButton.extended(
      //         onPressed: () async {
      //           if (_markers.length == 2) {
      //             var dis = await Geolocator.distanceBetween(
      //               _markers[0].position.latitude,
      //               _markers[0].position.longitude,
      //               _markers[1].position.latitude,
      //               _markers[1].position.longitude,
      //             );
      //             Fluttertoast.showToast(
      //                 msg: "${dis.toInt()}M",
      //                 toastLength: Toast.LENGTH_SHORT,
      //                 gravity: ToastGravity.BOTTOM,
      //                 backgroundColor: Colors.grey,
      //                 textColor: Colors.white,
      //                 fontSize: 16.0);
      //           }
      //         },
      //         label: Text('Distance'),
      //         icon: Icon(Icons.fmd_good_outlined),
      //       )
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _goToUniv() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_univ));
  }

  addMarks(pos) {
    setState(() {
      if (tf) {
        _line.clear();
        _markers.clear();
        _markers.add(Marker(position: pos, markerId: MarkerId('1')));
        tf = !tf;
      } else {
        _markers.add(Marker(
            position: pos,
            markerId: MarkerId('2'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue)));
        addLine(_markers[0].position, _markers[1].position);
        tf = !tf;
      }
    });
  }

  addLine(LatLng mark1, LatLng mark2) {
    setState(() {
      _line.add(Polyline(
          polylineId: PolylineId('poly'), points: [mark1, mark2], width: 5));
    });
  }

//지도를 사용하기 위해서는 접근 권한을 허용해야 한다.
//앱 실행 시 접근 권한이 허용되었는지 체크
//만약 권한이 없다면 권한 설정 창 띄우기
  _checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}