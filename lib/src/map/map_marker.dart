import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      infoWindow: InfoWindow(title: '서울특별시', snippet: 'address'),
    );

    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 14.0,
        ),
        markers: markers.values.toSet(),
      ),
    );
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
