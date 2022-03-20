import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_toy2/src/model/ev.dart';
import 'package:flutter_toy2/src/provider/ev_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:developer';

class MapWidget extends StatefulWidget {
  MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  // Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _controller;
  List<Marker> _markers = []; //marker들을 넣을 리스트

  bool tf = true;

  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final List<Marker> markers = [];
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
    // setCustomMapPin();
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

  late EvProvider _evProvider;
  // EvProvider 호출

// 마커 추가
  addMarker(Ev ev) {
    markers.add(Marker(
        // icon: BitmapDescriptor.fromBytes(markerIcon),
        position: LatLng(double.parse(ev.Y_CRDNT_VALUE.toString()),
            double.parse(ev.X_CRDNT_VALUE.toString())),
        markerId: MarkerId(ev.CLTUR_EVENT_ETC_NM.toString()),
        // icon: BitmapDescriptor.fromBytes(byte),
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(ev.CLTUR_EVENT_ETC_NM.toString()),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        // Text(ev.CLTUR_EVENT_ETC_NM.toString()),
                        Text("자치구명 : " + ev.ATDRC_NM.toString()),
                        Text("주소 : " +
                            ev.BASS_ADRES.toString() +
                            ev.DETAIL_ADRES.toString()),
                        Text("사용료 무료 여부 : " + ev.RNTFEE_FREE_AT.toString()),
                        Text("안내 URL : " + ev.GUIDANCE_URL.toString()),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("cancel"))
                  ],
                );
              });
        },
        infoWindow:
            InfoWindow(title: ev.CLTUR_EVENT_ETC_NM, snippet: ev.BASS_ADRES)));
    // print(markers);
  }

  // 리스트 뷰
  Widget _makeListView(List<Ev> evs) {
    for (int i = 0; i < evs.length; i++) {
      addMarker(evs[i]);
    }

    return GoogleMap(
      onMapCreated: (controller) {
        _controller = controller;
      },
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 14.0,
      ),
      markers: markers.toSet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of를 통해 데이터를 접근한다. builder만을 업데이트 하기 위해 listen은 false로 한다.
    _evProvider = Provider.of<EvProvider>(context, listen: false);
    _evProvider.loadEvs(); // EvProvider에 loadEvs()의 접근

    return Scaffold(
        appBar: AppBar(
          title: Text("Ev Provider"),
        ),
        // Consumer를 통해 데이터를 접근
        body: Consumer<EvProvider>(builder: (context, provider, wideget) {
          // 데이터가 있으면 _makeListView에 데이터를 전달
          if (provider.evs != null && provider.evs.length > 0) {
            return _makeListView(provider.evs);
            // _viewmap(provider.evs);
          }

          // 데이터가 없으면 CircularProgressIndicator 수행(로딩)
          return Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
