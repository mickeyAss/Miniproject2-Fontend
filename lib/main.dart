import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fontend_miniproject2/pages/login_user.dart';
import 'package:fontend_miniproject2/pages/select_login.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
      home: SelectLoginPage(),
    );
  }
}
