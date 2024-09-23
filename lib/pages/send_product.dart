import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fontend_miniproject2/config/config.dart';
import 'package:fontend_miniproject2/models/get_data_users.dart';

class SendProductPage extends StatefulWidget {
  int uid = 0;
  int myuid = 0;
  SendProductPage({super.key, required this.uid, required this.myuid});

  @override
  State<SendProductPage> createState() => _SendProductPageState();
}

class _SendProductPageState extends State<SendProductPage> {
  late GetDataUsers user;
  late Future<void> loadData_User;

  @override
  void initState() {
    super.initState();
    loadData_User = loadDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
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
  }
}
