import 'package:flutter/material.dart';

class HomeRiderPage extends StatefulWidget {
  final int uid;
  HomeRiderPage({super.key, required this.uid});

  @override
  State<HomeRiderPage> createState() => _HomeRiderPageState();
}

class _HomeRiderPageState extends State<HomeRiderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Rider'),
      ),
    );
  }
}
