import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fontend_miniproject2/config/config.dart';
import 'package:fontend_miniproject2/pages/send_user.dart';
import 'package:fontend_miniproject2/pages/login_user.dart';
import 'package:fontend_miniproject2/pages/profile_user.dart';
import 'package:fontend_miniproject2/pages/select_login.dart';
import 'package:fontend_miniproject2/models/get_data_users.dart';

class HomeUserPage extends StatefulWidget {
  final int uid;
  HomeUserPage({super.key, required this.uid});

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  late GetDataUsers user;
  late Future<void> loadData_User;
  GetStorage gs = GetStorage();

  @override
  void initState() {
    super.initState();
    loadData_User = loadDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'หน้าหลัก',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 72, 0, 0),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 72, 0, 0)),
              child: FutureBuilder(
                future: loadData_User,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading user data'));
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: ClipOval(
                          child: Image.network(
                            user.img,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            user.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Text(
                            user.lastname,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            // เมนูใน Drawer
            ListTile(
              leading: Icon(Icons.home),
              title: Text('หน้าหลัก'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('โปรไฟล์'),
              onTap: () {
                Get.to(() => ProfileUser(uid: widget.uid));
              },
            ),
            ListTile(
              leading: Icon(Icons.pin_drop_rounded),
              title: Text('ที่อยู่'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('ออกจากระบบ'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Center(
                        child: Text('ยืนยันการออกจากระบบ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              child: Text('ยกเลิก',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 72, 0, 0))),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 72, 0, 0),
                                    width: 2.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                            FilledButton(
                              child: Text('ยืนยัน'),
                              style: FilledButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 72, 0, 0),
                                foregroundColor: Colors.white,
                                textStyle: TextStyle(fontSize: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                elevation: 5,
                              ),
                              onPressed: () {
                                gs.remove('uid');
                                Get.offAll(() => SelectLoginPage());
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 72, 0, 0),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ตรวจสอบสถานะพัสดุ...',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              // ปุ่มส่งพัสดุ
              buildActionButton('ส่งพัสดุ', 'assets/images/truck.png', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SendUserPage(uid: widget.uid)),
                );
              }),
              SizedBox(height: 20),
              // ปุ่มรายการพัสดุ
              buildActionButton('รายการพัสดุ', 'assets/images/box.png', () {}),
              // FilledButton(
              //     onPressed: () async {
              //       var postion = await _determinePosition();
              //       log('${postion.latitude} ${postion.longitude}');
              //     },
              //     child: const Text('Get Location'))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActionButton(
      String title, String assetPath, VoidCallback onPressed) {
    return SizedBox(
      width: 200,
      height: 200,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 15,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(assetPath, width: 100, height: 100),
              Text(title, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  // โหลดข้อมูล User
  Future<void> loadDataUser() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    final response = await http.get(Uri.parse("$url/user/get/${widget.uid}"));
    if (response.statusCode == 200) {
      user = getDataUsersFromJson(response.body);
      log(response.body);
      setState(() {});
    } else {
      log('Error loading user data: ${response.statusCode}');
    }
  }

  // /// Determine the current position of the device.
  // ///
  // /// When the location services are not enabled or permissions
  // /// are denied the `Future` will return an error.
  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition();
  // }
}
