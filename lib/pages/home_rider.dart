import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:fontend_miniproject2/config/config.dart';
import 'package:fontend_miniproject2/pages/select_login.dart';
import 'package:fontend_miniproject2/pages/profile_user.dart';
import 'package:fontend_miniproject2/models/get_data_rider.dart';

class HomeRiderPage extends StatefulWidget {
  final int rid;
  HomeRiderPage({super.key, required this.rid});

  @override
  State<HomeRiderPage> createState() => _HomeRiderPageState();
}

class _HomeRiderPageState extends State<HomeRiderPage> {
  GetStorage gs = GetStorage();
  late GetDataRider rider;
  late Future<void> loadData_Rider;

  @override
  void initState() {
    super.initState();
    loadData_Rider = loadDataUser();
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
                future: loadData_Rider,
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
                            rider.img,
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
                            rider.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Text(
                            rider.lastname,
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
                // Get.to(() => ProfileUser(uid: widget.uid));
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
                                gs.remove('rid');
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
              SizedBox(height: 150),

              // ปุ่มรายการพัสดุ
              buildActionButton('รายการงาน', 'assets/images/box.png', () {}),
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
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // ให้ modal สามารถขยายได้เต็มหน้าจอ
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0), // ปรับขนาดความกว้างด้วย Padding
                child: FractionallySizedBox(
                  heightFactor: 0.9, // ความสูง modal 90% ของจอ
                  widthFactor: 10, // ความกว้าง modal 80% ของจอ
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              'รายการงาน',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Text('นี่คือรายละเอียดงานที่คุณเลือก...'),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // ปิด modal
                              },
                              child: Text('ปิด'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
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

    final response = await http.get(Uri.parse("$url/rider/get/${widget.rid}"));
    if (response.statusCode == 200) {
      rider = getDataRiderFromJson(response.body);
      log(response.body);
      setState(() {});
    } else {
      log('Error loading user data: ${response.statusCode}');
    }
  }
}
