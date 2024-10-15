import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fontend_miniproject2/config/config.dart';
import 'package:fontend_miniproject2/models/get_product.dart';
import 'package:fontend_miniproject2/pages/detail_product_send_user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailSendUserPage extends StatefulWidget {
  String track = "";
  DetailSendUserPage({super.key, required this.track});

  @override
  State<DetailSendUserPage> createState() => _DetailSendUserPageState();
}

class _DetailSendUserPageState extends State<DetailSendUserPage> {

  late GetProduct getp;
  late Future<void> loadData;

  void initState() {
    super.initState();
    loadData = loadDataProduct();

    log(widget.track.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("รายละเอียดการจัดส่ง"),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: loadData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error loading user data: ${snapshot.error}'));
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ผู้ส่ง",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        getp.senderName,
                        style: const TextStyle(color: Colors.black38),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        getp.senderLastname,
                        style: const TextStyle(color: Colors.black38),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        getp.senderPhone,
                        style: const TextStyle(color: Colors.black38),
                      )
                    ],
                  ),
                  Text(
                    getp.senderAddress,
                    style: const TextStyle(color: Colors.black38),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // เส้นกั้นระหว่างผู้ส่งและผู้รับ
                  const Divider(
                    thickness: 1, // ความหนาของเส้น
                    color: Colors.black26, // สีของเส้น
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "ผู้รับ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        getp.receiverName,
                        style: const TextStyle(color: Colors.black38),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        getp.receiverLastname,
                        style: const TextStyle(color: Colors.black38),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        getp.receiverPhone,
                        style: const TextStyle(color: Colors.black38),
                      )
                    ],
                  ),
                  Text(
                    getp.receiverAddress,
                    style: const TextStyle(color: Colors.black38),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  FilledButton(
                      onPressed: () {
                        Get.to(()=>DetailProductSendUserPage(track: getp.trackingNumber,));
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.black38,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // รูปร่างปุ่ม
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("รายละเอียดสินค้า",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                              Row(
                                children: [
                                  const Text("สถานะ : ",style: TextStyle(fontSize: 16,color:  Color.fromARGB(255, 72, 0, 0)),),
                                  Text(getp.proStatus,style: const TextStyle(fontSize: 16,color:  Color.fromARGB(255, 72, 0, 0)),),
                                ],
                              )
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ))
                ],
              ),
            );
          }),
    );
  }

  Future<void> loadDataProduct() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    final response =
        await http.get(Uri.parse("$url/product/get/${widget.track}"));
    if (response.statusCode == 200) {
      getp = getProductFromJson(response.body);
      log(response.body);
      setState(() {});
    } else {
      log('Error loading user data: ${response.statusCode}');
    }
  }
}
