import 'package:flutter/material.dart';
import 'package:prozone/screens/add-provider_screen.dart';
import 'package:prozone/utils/consts.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LIGHT_BLUE_ACCENT,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Provider", style: TextStyle(color: BLUE_HUE, fontSize: 18),),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AddProviderScreen.routeName),
            child: Container(
                margin: EdgeInsets.only(right: 16),
                child: Icon(Icons.add, color: BLUE_HUE)),
          )
        ],
      ),
      body:  Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Divider(
                  color: GREEN_HUE,
                  thickness: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
