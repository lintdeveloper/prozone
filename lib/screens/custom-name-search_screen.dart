import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:prozone/application.dart';
import 'package:prozone/enums/enums.dart';
import 'package:prozone/models/customProvider/custom-provider.dart';
import 'package:prozone/providers/helper_provider.dart';
import 'package:prozone/screens/provider-list_screen.dart';
import 'package:prozone/utils/utils.dart';

class CustomNameSearchScreen extends StatefulWidget {
  static String routeName = "/test-home";

  @override
  _CustomNameSearchScreenState createState() => _CustomNameSearchScreenState();
}

class _CustomNameSearchScreenState extends State<CustomNameSearchScreen> {
  List<Posts> _list = [];
  List<Posts> _search = [];
  var loading = false;
  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    final response =
    await http.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(Posts.formJson(i));
          loading = false;
        }
      });
    }
  }

  TextEditingController controller = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget appBarTitle = Text('Manage all users');
  Icon actionIcon = Icon(Icons.search);
  final TextEditingController _controller = TextEditingController();


  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.title.contains(text) || f.id.toString().contains(text))
        _search.add(f);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _helper = Provider.of<HelperProvider>(context);
    final _size = MediaQuery.of(context).size;
    print(_search);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: BLUE_HUE),
        title: appBarTitle,
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(Icons.close);
                  this.appBarTitle = TextField(
                    controller: _controller,
                    style: TextStyle(
                      color: BLUE_HUE,
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search for name",
                        hintStyle: TextStyle(color: GREEN_HUE, )),
                    onChanged: _filter,
                  );
                } else {
                  this.actionIcon = Icon(Icons.search);
                  this.appBarTitle = Text('Manage all users');
                  // go back to showing all users
                }
              });
            },
          ),
        ]),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              // Card(
              //   child: ListTile(
              //     leading: Icon(Icons.search),
              //     title: TextField(
              //       controller: controller,
              //       onChanged: onSearch,
              //       decoration: InputDecoration(
              //           hintText: "Search", border: InputBorder.none),
              //     ),a
              //     trailing: IconButton(
              //       onPressed: () {
              //         controller.clear();
              //         onSearch('');
              //       },
              //       icon: Icon(Icons.cancel),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: FutureBuilder<List<CustomProviderResponse>>(
              //         future: getProviderListAction(
              //             context: context, helper: _helper),
              //         builder: (context, snapshot) {
              //           if (snapshot.hasError) print(snapshot.error);
              //           return snapshot.hasData
              //               ? ProviderList(
              //               customProviderList: snapshot.data,
              //               scaffoldKey: _scaffoldKey)
              //               : Container(
              //               margin: EdgeInsets.only(
              //                   top: _size.height * 0.40),
              //               child: Center(
              //                   child: CircularProgressIndicator()));
              //         }),
              //   ),
              // )
              // loading
              //     ? Center(
              //   child: CircularProgressIndicator(),
              // )
              //     : Expanded(
              //   child: _search.length != 0 || controller.text.isNotEmpty
              //       ? ListView.builder(
              //     itemCount: _search.length,
              //     itemBuilder: (context, i) {
              //       final b = _search[i];
              //       return Container(
              //           padding: EdgeInsets.all(10.0),
              //           child: Column(
              //             crossAxisAlignment:
              //             CrossAxisAlignment.start,
              //             children: <Widget>[
              //               Text(
              //                 b.title,
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 18.0),
              //               ),
              //               SizedBox(
              //                 height: 4.0,
              //               ),
              //               Text(b.body),
              //             ],
              //           ));
              //     },
              //   )
              //       : ListView.builder(
              //     itemCount: _list.length,
              //     itemBuilder: (context, i) {
              //       final a = _list[i];
              //       return Container(
              //           padding: EdgeInsets.all(10.0),
              //           child: Column(
              //             crossAxisAlignment:
              //             CrossAxisAlignment.start,
              //             children: <Widget>[
              //               Text(
              //                 a.title,
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 18.0),
              //               ),
              //               SizedBox(
              //                 height: 4.0,
              //               ),
              //               Text(a.body),
              //             ],
              //           ));
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  StreamController<List<CustomProviderResponse>> _streamController = StreamController<List<CustomProviderResponse>>();
  Stream<List<CustomProviderResponse>> get _stream => _streamController.stream;
  _filter(String searchQuery) {
    return searchQuery;
  }

  Future<List<CustomProviderResponse>> getProviderListAction(
      {BuildContext context, HelperProvider helper}) async {
    final _helper = Provider.of<HelperProvider>(context);
    String _token;
    final application = Application.instance();
    await application.getToken("authToken").then((token) {
      _token = token["value"];
    });
    List<CustomProviderResponse> responsePayload =
    await helper.getCustomProviderResponseList(
        authToken: _token, errorCallback: errorCallback);
    return responsePayload;
  }

  void errorCallback(String msg) {
    Navigator.of(context).pop();
    ShowSnackBar(scaffoldKey: _scaffoldKey, msg: msg);
  }
}


class Posts {
  final int userId;
  final int id;
  final String title;
  final String body;

  Posts({this.userId, this.id, this.title, this.body});

  factory Posts.formJson(Map <String, dynamic> json){
    return new Posts(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}