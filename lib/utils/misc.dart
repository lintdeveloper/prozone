
import 'package:flutter/material.dart';
import 'package:prozone/screens/home.dart';
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

 void showAlertDialog(BuildContext context, {String success}) {
   // flutter defined function
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: Text(
           'Success',
           textAlign: TextAlign.center,
           style: TextStyle(
               fontSize: 18.0,
               color: GREEN_HUE,
               fontWeight: FontWeight.w500),
         ),
         content: Column(
           mainAxisSize: MainAxisSize.min,
           children: <Widget>[
             new Text(
               "$success",
               textAlign: TextAlign.center,
               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
             ),
             SizedBox(height: 44,),
             Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(4.0),
                 color: GREEN_HUE
               ),
               width: 133.0,
               height: 40,
               child: RaisedButton(
                 color: GREEN_HUE,
                 onPressed: () async {
                   Navigator.pushNamed(context, HomeScreen.routeName);
                 },
                 child: Text(
                   "Proceed",
                   style: TextStyle(
                       fontWeight: FontWeight.normal,
                       fontSize: 16.0,
                       color: Color.fromRGBO(250, 247, 255, 1)),
                 ),
               ),
             )
           ],
         ),

       );
     },
   );
 }

List<Widget> getRatings(int rating) {
  final starWidgets = <Widget>[];
  for (var i = 0; i < rating; i++) {
    starWidgets.add(Icon(Icons.star, size: 16, color: GREEN_HUE));
  }
  return starWidgets;
}