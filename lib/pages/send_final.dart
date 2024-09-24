import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fontend_miniproject2/config/config.dart';
import 'package:fontend_miniproject2/pages/home_user.dart';
import 'package:fontend_miniproject2/models/get_user2.dart';
import 'package:fontend_miniproject2/models/add_user_request.dart';

class SendFinalPage extends StatefulWidget {
  int uid = 0;
  int myuid = 0;
  final String nameProduct;
  final String detailProduct;
  final XFile? image;
  SendFinalPage(
      {super.key,
      required this.uid,
      required this.myuid,
      required this.detailProduct,
      this.image,
      required this.nameProduct});

  @override
  State<SendFinalPage> createState() => _SendFinalPageState();
}

class _SendFinalPageState extends State<SendFinalPage> {
  late Future<void> loadData_User;
  List<GetUser2> data = [];

  @override
  void initState() {
    super.initState();
    loadData_User = loadDataUser();

    // Log ข้อมูล
    log('UID: ${widget.uid}');
    log('MyUID: ${widget.myuid}');
    log('Product Name: ${widget.nameProduct}');
    log('Product Detail: ${widget.detailProduct}');
    if (widget.image != null) {
      log('Image Path: ${widget.image!.path}');
    } else {
      log('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ตรวจสอบข้อมูลการจัดส่ง',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: loadData_User,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey, width: 2), // ขอบกรอบ
                      borderRadius: BorderRadius.circular(8), // มุมโค้ง
                    ),
                    padding: const EdgeInsets.all(10), // ระยะห่างภายใน
                    child: Column(
                      children: [
                        if (data.isNotEmpty)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'ผู้ส่ง: ${data[0].name} ${data[0].lastname}',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${data[0].phone}',
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${data[0].address}',
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // เพิ่มเส้นขั้นที่นี่
                              const Divider(
                                  height: 30,
                                  thickness: 1,
                                  color: Colors.grey), // เส้นขั้น
                            ],
                          ),
                        if (data.length > 1)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'ผู้รับ: ${data[1].name} ${data[1].lastname}',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${data[1].phone}',
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${data[1].address}',
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                "รายการพัสดุ",
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2), // ขอบกรอบ
                borderRadius: BorderRadius.circular(8), // มุมโค้ง
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 150, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'ชื่อพัสดุ: ${widget.nameProduct}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    'รายละเอียด: ${widget.detailProduct}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  widget.image != null
                      ? Image.file(
                          File(widget.image!.path),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : const Text('ไม่มีรูปภาพ'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 72, 0, 0),
                    padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                onPressed: addProduct,
                child: const Text("ถัดไป"))
          ],
        ),
      ),
    );
  }

  // โหลดข้อมูล User
  Future<void> loadDataUser() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    final response = await http
        .get(Uri.parse("$url/user/get/${widget.uid}/${widget.myuid}"));
    log('Requesting URL: $url');
    log(response.body);
    var jsonResponse = (response.body);

    // แปลงข้อมูล JSON เป็น List ของ GetUser2
    data = getUser2FromJson(jsonResponse);
  }

  void addProduct() async {
    var model = AddUserRequest(
      proName: widget.nameProduct,
      proDetail: widget.detailProduct,
      proImg: widget.image!.path,
      uidFkSend: data[0].uid.toString(),
      uidFkAccept: data[1].uid.toString(),
    );

    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    var response = await http.post(
      Uri.parse("$url/product/add"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
      body: addUserRequestToJson(model),
    );

    log(response.body);

    if (response.statusCode == 201) {
      // แสดง Dialog เมื่อทำงานสำเร็จ
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'ติดตามการจัดส่ง',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    child: const Text('ตกลง'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeUserPage(
                            uid: widget.uid,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    } else {
      // จัดการกรณีที่การทำงานไม่สำเร็จ (สามารถเพิ่มได้ถ้าต้องการ)
      log('Error: ${response.statusCode}');
    }
  }
}
