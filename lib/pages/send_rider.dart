import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fontend_miniproject2/config/config.dart';
import 'package:fontend_miniproject2/models/get_user2.dart';
import 'package:fontend_miniproject2/models/get_product.dart';
import 'package:fontend_miniproject2/models/get_data_users.dart';

class SendRederPage extends StatefulWidget {
  int rid = 0;
  String traking_number = '';
  SendRederPage({super.key, required this.rid, required this.traking_number});

  @override
  State<SendRederPage> createState() => _SendRederPageState();
}

class _SendRederPageState extends State<SendRederPage> {
  LatLng? latLng; // ใช้เป็น nullable ก่อนเพื่อป้องกันการใช้ค่าเริ่มต้น

  MapController mapController = MapController();
  late GetProduct getp;
  List<GetUser2> getuser = [];
  var db = FirebaseFirestore.instance;
  late Future<void> loadData;
  late StreamSubscription listener;

  @override
  void dispose() {
    listener.cancel(); // ปิดการฟังเมื่อไม่ใช้งาน
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation(); // เรียกฟังก์ชันที่ใช้ async

    loadData = loadDataProduct();

    log(widget.traking_number.toString());
    log(widget.rid.toString());

    // ติดตามเอกสารใน Firestore
    final docRef = db.collection("inbox2").doc("Doc1");
    listener = docRef.snapshots().listen(
      (event) {
        var data = event.data();
        if (data != null) {
          latLng = LatLng(data['latitude'], data['longitude']); // อัปเดตตำแหน่ง
          setState(() {}); // รีเรนเดอร์เมื่อได้ข้อมูลใหม่

          log("current data: ${event.data()}");
        }
      },
      onError: (error) => log("Listen failed: $error"),
    );

    // ติดตามการเปลี่ยนแปลงตำแหน่ง
    _startListeningPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS นำทาง'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: _cancelTracking, // เรียกฟังก์ชันเมื่อกดปุ่ม Cancel
          ),
        ],
      ),
      body: latLng == null // เช็คว่า latLng ถูกตั้งค่าแล้วหรือไม่
          ? const Center(
              child:
                  const CircularProgressIndicator()) // แสดงวงกลมโหลดหากยังไม่มีตำแหน่ง
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
                            point: latLng!, // ใช้ตำแหน่งปัจจุบัน
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.navigation,
                              size: 40,
                              color: Color.fromARGB(255, 195, 0, 0),
                            ),
                          ),
                          Marker(
                            point: LatLng(39.3551,
                                -123.01), // ใช้ละติจูดและลองจิจูดที่ต้องการ
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.pin_drop, // ไอคอนที่ใช้สำหรับ Marker ใหม่
                              size: 40,
                              color: Colors.blue, // สีของ Marker ใหม่
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

  Future<void> _loadCurrentLocation() async {
    try {
      Position position = await _determinePosition(); // ดึงตำแหน่งปัจจุบัน
      log('${position.latitude} ${position.longitude}');
      latLng = LatLng(position.latitude, position.longitude);
      _updatePositionInFirestore(position); // อัปเดตตำแหน่งใน Firestore
      setState(() {}); // รีเรนเดอร์เมื่อได้ตำแหน่ง
    } catch (e) {
      log('Error: $e'); // จัดการข้อผิดพลาดที่อาจเกิดขึ้น
    }
  }

  void _startListeningPosition() {
    // ติดตามตำแหน่งอย่างต่อเนื่อง
    Geolocator.getPositionStream().listen((Position position) {
      latLng = LatLng(position.latitude, position.longitude);
      _updatePositionInFirestore(position); // อัปเดตตำแหน่งใน Firestore
      setState(() {}); // รีเรนเดอร์เมื่อได้ตำแหน่งใหม่

      // ย้าย Marker ไปยังตำแหน่งใหม่
      mapController.move(latLng!, 15.0); // ย้ายแผนที่ไปยังตำแหน่งใหม่
    });
  }

  Future<void> _updatePositionInFirestore(Position position) async {
    await db.collection("inbox2").doc("Doc1").set({
      'latitude': position.latitude,
      'longitude': position.longitude,
    });
  }

  void _cancelTracking() {
    listener.cancel(); // หยุดการฟังข้อมูลจาก Firestore
    Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
  }

  Future<void> loadDataProduct() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    final response =
        await http.get(Uri.parse("$url/product/get/${widget.traking_number}"));
    if (response.statusCode == 200) {
      getp = getProductFromJson(response.body);
      log(response.body);
      setState(() {});
    } else {
      log('Error loading user data: ${response.statusCode}');
    }

    final user = await http
        .get(Uri.parse("$url/user/get/${getp.uidFkSend}/${getp.uidFkAccept}"));
    if (user.statusCode == 200) {
      getuser = getUser2FromJson(user.body);
      log(user.body);
      setState(() {});
    } else {
      log('Error loading user data: ${user.statusCode}');
    }
  }
}
