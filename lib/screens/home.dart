import 'package:flutter/material.dart';
import 'package:prozone/application.dart';
import 'package:prozone/mixins/index.dart';
import 'package:prozone/models/provider_model.dart';
import 'package:prozone/providers/helper_provider.dart';
import 'package:prozone/screens/add-provider_screen.dart';
import 'package:prozone/screens/provider-list_screen.dart';
import 'package:prozone/utils/consts.dart';
import 'package:provider/provider.dart';
import 'package:prozone/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _helper = Provider.of<HelperCustomProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: LIGHT_BLUE_ACCENT,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Provider", style: TextStyle(color: BLUE_HUE, fontSize: 18),),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, AddProviderScreen.routeName),
            child: Container(
                margin: EdgeInsets.only(right: 16),
                child: Icon(Icons.add, color: BLUE_HUE)),
          )
        ],
        bottom: PreferredSize(
          child: Divider(
            color: GREEN_HUE,
            height: 1,
          )
        ),
      ),
      body: ResponsiveSafeArea(builder: (context, size) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder<List<CustomProvider>>(
                    future: getProviderListAction(
                        context: context, helper: _helper),
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        print(snapshot.error);
                      return snapshot.hasData ? ProviderList(customProviderList: snapshot.data)
                          :  Center(child: CircularProgressIndicator());
                    }),
              ),
            )
          ],
        );
      }),
    );
  }

  Future<List<CustomProvider>> getProviderListAction(
      {BuildContext context, HelperCustomProvider helper}) async {
    String _token;
    final application = Application.instance();
    await application.getToken("authToken").then((token) {
      _token = token["value"];
    });
    List<CustomProvider> responsePayload = await helper.getCustomProviderList(
        authToken: _token, errorCallback: errorCallback);
    return responsePayload;
  }

  void errorCallback(String msg) {
    Navigator.of(context).pop();
    ShowSnackBar(scaffoldKey: _scaffoldKey, msg: msg);
  }
}
