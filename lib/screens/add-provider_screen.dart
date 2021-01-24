import 'package:flutter/material.dart';
import 'package:prozone/utils/consts.dart';

class AddProviderScreen extends StatefulWidget {
  static String routeName = "add-provider";

  @override
  _AddProviderScreenState createState() => _AddProviderScreenState();
}

class _AddProviderScreenState extends State<AddProviderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Add Provider", style: TextStyle(color: BLUE_HUE, fontSize: 16)),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: BLUE_HUE),
      ),
      body: Container(),
    );
  }
}
