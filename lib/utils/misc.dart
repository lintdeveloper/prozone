
import 'package:flutter/material.dart';
import 'package:prozone/utils/utils.dart';

class ShowDialog {
  ShowDialog({BuildContext context}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        }
    );
  }
}

class ShowSnackBar {
  ShowSnackBar({GlobalKey<ScaffoldState> scaffoldKey, String msg, Duration duration}) {
    final snackBar = SnackBar(
      backgroundColor: BLUE_HUE,
      content: Text(
        '$msg',
        textAlign: TextAlign.center,
        style: new TextStyle(
            height: 1.5,
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w600),
      ),
      duration: Duration(seconds: 4),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
