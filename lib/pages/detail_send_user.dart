import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fontend_miniproject2/config/config.dart';
import 'package:fontend_miniproject2/models/get_product.dart';
import 'package:http/http.dart' as http;

class DetailSendUserPage extends StatefulWidget {
  String track = "";
  DetailSendUserPage({super.key, required this.track});

  @override
  State<DetailSendUserPage> createState() => _DetailSendUserPageState();
}

class _DetailSendUserPageState extends State<DetailSendUserPage> {
  var firepro;

  var db = FirebaseFirestore.instance;
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
        title: Text("รายละเอียดการจัดส่ง"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          
        ],
      ),
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