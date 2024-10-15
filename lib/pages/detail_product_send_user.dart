import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fontend_miniproject2/config/config.dart';
import 'package:fontend_miniproject2/models/get_product.dart';
import 'package:http/http.dart' as http;

class DetailProductSendUserPage extends StatefulWidget {
  String track = "";
  DetailProductSendUserPage({super.key, required this.track});

  @override
  State<DetailProductSendUserPage> createState() =>
      _DetailProductSendUserPageState();
}

class _DetailProductSendUserPageState extends State<DetailProductSendUserPage> {
  late GetProduct getp;
  late Future<void> loadData;

  void initState() {
    super.initState();
    loadData = loadDataProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายละเอียดสินค้า"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getp.proName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "เลขพัสดุ : ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(getp.trackingNumber)
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    getp.proDetail,
                    style: TextStyle(color: Colors.black45),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          getp.proImg,
                          width: 450,
                          height: 300,
                          fit: BoxFit.cover,
                          
                        ),
                      ),
                    ),
                  ),
                   const Divider(
                    thickness: 1, // ความหนาของเส้น
                    color: Colors.black26, // สีของเส้น
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("สถานะ : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 72, 0, 0)),),
                      Text(getp.proStatus,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 72, 0, 0)),),
                    ],
                  )

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
