import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fontend_miniproject2/config/config.dart';
import 'package:fontend_miniproject2/pages/send_rider.dart';
import 'package:fontend_miniproject2/models/get_status.dart';
import 'package:fontend_miniproject2/models/get_product.dart';

class ParcelReceicedRiderPage extends StatefulWidget {
  int rid = 0;
  String trackingNumber = '';
  ParcelReceicedRiderPage(
      {super.key, required this.rid, required this.trackingNumber});

  @override
  State<ParcelReceicedRiderPage> createState() =>
      _ParcelReceicedRiderPageState();
}

class _ParcelReceicedRiderPageState extends State<ParcelReceicedRiderPage> {
  late GetProduct getp;
  List<GetStatus> getstatus = [];
  late Future<void> loadData;

  String? imagePath; // ตัวแปรเก็บที่อยู่ของรูปภาพที่ถ่าย

  String deliveryStatusMessage =
      'กำลังดำเนินการจัดส่ง'; // ตัวแปรเก็บข้อความสถานะการจัดส่ง

  @override
  void initState() {
    super.initState();
    log(widget.rid.toString());
    log(widget.trackingNumber.toString());
    loadData = loadDataProduct(); // โหลดข้อมูลสินค้า
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ดำเนินการ',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              FutureBuilder(
                future: loadData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading user data'));
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            getp.proImg,
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              FutureBuilder(
                  future: loadData,
                  builder: (context, snapshot) {
                    return SingleChildScrollView(
                      child: Column(
                        children: getstatus.map((e) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: const Divider(
                                    height: 30,
                                    thickness: 1,
                                    color: Colors.grey),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'สถานะ : ${e.staname}',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 72, 0, 0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  }),
              SingleChildScrollView(
                child: Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                    child: imagePath == null
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: 230,
                            child: OutlinedButton(
                              onPressed: openCamera,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Color.fromARGB(255, 72, 0, 0),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 60,
                                    color: Color.fromARGB(255, 72, 0, 0),
                                  ),
                                  Text(
                                    'ถ่ายรูปภาพประกอบสถานะ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 72, 0, 0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Divider(
                                  height: 30, thickness: 1, color: Colors.grey),
                              Row(
                                children: [
                                  Text(
                                    'สถานะ : ${deliveryStatusMessage}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 72, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'รูปภาพจากไรเดอร์',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.file(
                                      File(imagePath!),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
          // ปุ่มรับพัสดุอยู่ติดขอบล่าง
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 72, 0, 0),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: updateProStatus,
                child: const Text(
                  'เริ่มจัดส่งพัสดุ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadDataProduct() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    final response =
        await http.get(Uri.parse("$url/product/get/${widget.trackingNumber}"));
    if (response.statusCode == 200) {
      getp = getProductFromJson(response.body);
      log(response.body);
    } else {
      log('Error loading user data: ${response.statusCode}');
    }

    final responsestatus = await http
        .get(Uri.parse("$url/product/get-status/${widget.trackingNumber}"));
    if (responsestatus.statusCode == 200) {
      getstatus = getStatusFromJson(responsestatus.body);
      log(response.body);
    } else {
      log('Error loading user data: ${response.statusCode}');
    }
  }

  // ฟังก์ชันสำหรับเปิดกล้อง
  Future<void> openCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        imagePath = photo.path; // เก็บที่อยู่ของรูปภาพที่ถ่าย
      });
      log('Image path: ${photo.path}');
    } else {
      log('No image selected.');
    }
  }

  // ฟังก์ชันสำหรับอัปเดตสถานะ
  Future<void> updateProStatus() async {
    // ดึง reference ไปที่ collection ชื่อ 'inbox'
    CollectionReference inboxCollection =
        FirebaseFirestore.instance.collection('inbox');

    // เทียบ documentId กับ getp.pid
    DocumentReference documentRef = inboxCollection.doc(getp.pid.toString());

    // ตรวจสอบว่ามีเอกสารที่ตรงกับ documentId หรือไม่
    DocumentSnapshot docSnapshot = await documentRef.get();
    if (docSnapshot.exists) {
      // อัปโหลดรูปภาพไปยัง Firebase Storage และรับ URL
      String? imageUrl = await uploadImage();

      if (imageUrl != null) {
        // ถ้ามีเอกสารที่ตรงกับ documentId ให้ทำการอัปเดต pro_status และเพิ่ม URL รูปภาพ
        await documentRef.update({
          'pro_status': 'กำลังดำเนินการจัดส่ง',
          'image_status3': imageUrl // เพิ่ม URL รูปภาพเข้าในเอกสาร
        });
        log('Updated pro_status and image_url for documentId: ${getp.pid}');
      } else {
        log('Image upload failed.');
        return; // หยุดการทำงานหากอัปโหลดรูปภาพไม่สำเร็จ
      }
    } else {
      log('Document with pid: ${getp.pid} does not exist.');
      return; // หยุดการทำงานหากไม่พบ document
    }

    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    // เตรียมข้อมูลสำหรับ POST ไปยังเส้น API ของ status
    var postData = {
      "uid_send": getp.senderUid,
      "uid_accept": getp.receiverUid,
      "staname": deliveryStatusMessage,
      "tacking": getp.trackingNumber
    };

    // POST ข้อมูลไปยัง API
    final postResponse = await http.post(
      Uri.parse("$url/product/add-status"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(postData),
    );

    if (postResponse.statusCode == 201) {
      log('Status successfully posted to API');
    } else {
      log('Failed to post status: ${postResponse.body}');
      return; // หยุดการทำงานหาก POST ไม่สำเร็จ
    }

    var putData = {
      "pro_status": deliveryStatusMessage,
    };
    final updateStatus = await http.put(
      Uri.parse("$url/product/update-status/${getp.pid}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(putData),
    );

    if (updateStatus.statusCode == 200) {
      log('Status successfully updated to API');
      Get.to(
        () => SendRederPage(
          rid: widget.rid,
          trackingNumber: widget.trackingNumber,
        ),
      );
    } else {
      log('Failed to update status: ${updateStatus.body}');
      return; // หยุดการทำงานหาก PUT ไม่สำเร็จ
    }
  }

  Future<String?> uploadImage() async {
    if (imagePath != null) {
      try {
        // สร้าง reference ไปยัง Firebase Storage
        final ref = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

        // อัปโหลดไฟล์ไปยัง Firebase Storage
        await ref.putFile(File(imagePath!));

        // รับ URL ของภาพที่อัปโหลด
        String downloadUrl = await ref.getDownloadURL();

        log('Image uploaded successfully: $downloadUrl');
        return downloadUrl; // ส่งกลับ URL
      } catch (e) {
        log('Error uploading image: $e');
        return null; // ส่งกลับ null หากเกิดข้อผิดพลาด
      }
    } else {
      log('No image selected');
      return null; // ส่งกลับ null หากไม่มีรูปภาพ
    }
  }
}
