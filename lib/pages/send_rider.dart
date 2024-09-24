import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';

class SendRederPage extends StatefulWidget {
  SendRederPage({super.key});

  @override
  State<SendRederPage> createState() => _SendRederPageState();
}

class _SendRederPageState extends State<SendRederPage> {
  LatLng? latLng; // ใช้เป็น nullable ก่อนเพื่อป้องกันการใช้ค่าเริ่มต้น
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation(); // เรียกฟังก์ชันที่ใช้ async
  }

  Future<void> _loadCurrentLocation() async {
    try {
      Position position = await _determinePosition(); // ดึงตำแหน่งปัจจุบัน
      log('${position.latitude} ${position.longitude}');
      latLng = LatLng(position.latitude, position.longitude);
      setState(() {}); // รีเรนเดอร์เมื่อได้ตำแหน่ง
    } catch (e) {
      log('Error: $e'); // จัดการข้อผิดพลาดที่อาจเกิดขึ้น
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS นำทาง'),
      ),
      body: latLng == null // เช็คว่า latLng ถูกตั้งค่าแล้วหรือไม่
          ? Center(
              child:
                  CircularProgressIndicator()) // แสดงวงกลมโหลดหากยังไม่มีตำแหน่ง
          : Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter: latLng!,
                      initialZoom: 15.0,
                      onMapReady: () {
                        // ย้ายไปยังตำแหน่งที่ดึงมาได้เมื่อแผนที่พร้อม
                        mapController.move(latLng!, 15.0);
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                        maxNativeZoom: 19,
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: latLng!,
                            width: 40,
                            height: 40,
                            child: Icon(
                              Icons.navigation,
                              size: 40,
                              color: const Color.fromARGB(255, 195, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
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

    return await Geolocator.getCurrentPosition();
  }
}
