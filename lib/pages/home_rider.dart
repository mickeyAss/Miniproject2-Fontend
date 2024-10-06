import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fontend_miniproject2/config/config.dart';
import 'package:fontend_miniproject2/pages/send_rider.dart';
import 'package:fontend_miniproject2/pages/select_login.dart';
import 'package:fontend_miniproject2/pages/profile_user.dart';
import 'package:fontend_miniproject2/models/get_data_rider.dart';
import 'package:fontend_miniproject2/models/get_all_product.dart';

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
  late Future<void> loadData_product;
  List<GetAllProduct> data = [];
  TextEditingController doc1 = TextEditingController();
  TextEditingController header = TextEditingController();
  TextEditingController message = TextEditingController();

  var db = FirebaseFirestore.instance;

  late StreamSubscription listener;

  @override
  void initState() {
    super.initState();
    loadData_Rider = loadDataUser();
    loadData_product = loadDataProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'หน้าหลัก',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 72, 0, 0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Color.fromARGB(255, 72, 0, 0)),
              child: FutureBuilder(
                future: loadData_Rider,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading user data'));
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
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            rider.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            rider.lastname,
                            style: const TextStyle(
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
              leading: const Icon(Icons.home),
              title: const Text('หน้าหลัก'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('โปรไฟล์'),
              onTap: () {
                // Get.to(() => ProfileUser(uid: widget.uid));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pin_drop_rounded),
              title: const Text('ที่อยู่'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('ออกจากระบบ'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text('ยืนยันการออกจากระบบ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              child: const Text('ยกเลิก',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 72, 0, 0))),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 72, 0, 0),
                                    width: 2.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                            FilledButton(
                              child: const Text('ยืนยัน'),
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 72, 0, 0),
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(fontSize: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                elevation: 5,
                              ),
                              onPressed: () {
                                gs.remove('rid');
                                Get.offAll(() => const SelectLoginPage());
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
        color: const Color.fromARGB(255, 72, 0, 0),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ปุ่มรายการพัสดุ
              SizedBox(
                width: 200,
                height: 200,
                child: FilledButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: const Radius.circular(20)),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: FractionallySizedBox(
                            heightFactor: 0.9,
                            widthFactor: 1.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'รายการงาน',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 20),
                                      FutureBuilder(
                                        future:
                                            loadData_product, // เรียกฟังก์ชันที่ดึงข้อมูล
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return const Center(
                                                child: Text('เกิดข้อผิดพลาด'));
                                          } else {
                                            return SingleChildScrollView(
                                              child: Column(
                                                children: data.map<Widget>((e) {
                                                  return ExpansionTile(
                                                    title: Text(e.proName),
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: const Text(
                                                            'รายละเอียดสินค้า'),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(e.proDetail),
                                                            Text(
                                                                'เลขพัสดุ: ${e.trackingNumber}'),
                                                          ],
                                                        ),
                                                      ),
                                                      FilledButton(
                                                        onPressed: () async {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SendRederPage(),
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                            'รับงาน'),
                                                      ),
                                                    ],
                                                  );
                                                }).toList(),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context); // ปิด modal
                                        },
                                        child: const Text('ปิด'),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/box.png',
                            width: 100, height: 100),
                        const Text('รายการงาน', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),

              Column(
                children: [
                  const Text('Document'),
                  TextField(
                    controller: doc1,
                  ),
                  const Text('Name'),
                  TextField(
                    controller: header,
                  ),
                  const Text('Message'),
                  TextField(
                    controller: message,
                  ),
                  FilledButton(
                      onPressed: () {
                        var db = FirebaseFirestore.instance;

                        var data = {
                          'header': header.text,
                          'message': message.text,
                        };

                        db.collection('inbox').doc('Room1234').set(data);
                      },
                      child: const Text('Add Data'))
                ],
              ),

              FilledButton(
                  onPressed: () {}, child: const Text('Start Real-time Get')),
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

  Future<void> loadDataProduct() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    final datapro = await http.get(Uri.parse("$url/product/get-all"));
    log('Requesting URL: $url');
    log(datapro.body);

    if (datapro.statusCode == 200) {
      data = getAllProductFromJson(datapro.body);

      setState(() {});
    } else {
      log('Error loading user data: ${datapro.statusCode}');
    }
  }
}
