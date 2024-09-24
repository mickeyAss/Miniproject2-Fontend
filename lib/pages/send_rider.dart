import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SendRederPage extends StatefulWidget {
  String latitude = '';
  String longitude = '';
  SendRederPage({super.key, required this.latitude, required this.longitude});

  @override
  State<SendRederPage> createState() => _SendRederPageState();
}

class _SendRederPageState extends State<SendRederPage> {
  CameraPosition initPosition = const CameraPosition(
    target: LatLng(16.246671218679253, 103.25207957788868),
    zoom: 17,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log('Latitude: ${widget.latitude}');
    log('Longitude: ${widget.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS นำทาง'),
      ),
    );
  }
}
