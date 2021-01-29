import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:prozone/application.dart';
import 'package:prozone/mixins/index.dart';
import 'package:prozone/models/customProvider/custom-provider.dart';
import 'package:prozone/models/models.dart';
import 'package:prozone/providers/helper_provider.dart';
import 'package:prozone/utils/consts.dart';
import 'package:prozone/utils/utils.dart';

class SearchOptionsScreen extends StatefulWidget {
  static String routeName = "/search-options";

  @override
  _SearchOptionsScreenState createState() => _SearchOptionsScreenState();
}

class _SearchOptionsScreenState extends State<SearchOptionsScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ProviderType _selectedProviderType;
  ActiveStatus _selectedActiveStatus;
  List<ProviderType> _providerTypeList;
  List<CustomState> _customStateList;
  CustomState _selectedState;

  String _providerName;
  String _providerDescription;
  String _providerAddress;
  double _providerRating;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getData();
    });
  }

  Future<void> getData() async {
    _providerTypeList = await getProviderTypeAction(context: context);
    _customStateList = await getStatesAction(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final _helper = Provider.of<HelperProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: BLUE_HUE),
        title: Text("Search Provider", style: TextStyle(color: BLUE_HUE, fontWeight: FontWeight.w400, fontSize: 16)),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: GREEN_HUE,
            height: 0.8,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
      ),
      body: ResponsiveSafeArea(builder: (context, size) {
        return Container(
          margin: EdgeInsets.only(top: 16, bottom: 30, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ActionChip(
                elevation: 8.0,
                padding: EdgeInsets.all(2.0),
                avatar: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: Icon(Icons.ac_unit_rounded),
                ),
                label: Container(
                    width: 80,
                    height: 40,
                    child: Center(
                        child: Text(
                          "By Name",
                          style: TextStyle(
                              fontSize: 12, color: BLUE_HUE, fontWeight: FontWeight.w400),
                        ))),
                onPressed: () {

                },
                backgroundColor: Colors.grey[200],
                shape: StadiumBorder(
                  side: BorderSide(
                      width: 1,
                      color: Colors.greenAccent,
                    ),
                ),
              ),
              ActionChip(
                elevation: 8.0,
                padding: EdgeInsets.all(2.0),
                avatar: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: Icon(Icons.apartment_sharp),
                ),
                label: Container(
                    width: 80,
                    height: 40,
                    child: Center(
                        child: Text(
                          "By Location",
                          style: TextStyle(
                              fontSize: 12, color: BLUE_HUE, fontWeight: FontWeight.w400),
                        ))),
                onPressed: () {

                },
                backgroundColor: Colors.grey[200],
                shape: StadiumBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.greenAccent,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Future<List<ProviderType>> getProviderTypeAction(
      {BuildContext context}) async {
    final _helper = Provider.of<HelperProvider>(context, listen: false);
    String _token;
    final application = Application.instance();
    await application.getToken("authToken").then((token) {
      _token = token["value"];
    });

    List<ProviderType> responsePayload = await _helper.getCustomProviderType(
        authToken: _token, errorCallback: errorCallback);
    return responsePayload;
  }

  Future<List<CustomState>> getStatesAction({BuildContext context}) async {
    final _helper = Provider.of<HelperProvider>(context, listen: false);
    String _token;
    final application = Application.instance();
    await application.getToken("authToken").then((token) {
      _token = token["value"];
    });

    List<CustomState> responsePayload = await _helper.getStateList(
        authToken: _token, errorCallback: errorCallback);
    return responsePayload;
  }

  void errorCallback(String msg) {
    Navigator.of(context).pop();
    ShowSnackBar(scaffoldKey: _scaffoldKey, msg: msg);
  }

  Future<CustomProviderResponse> addProvider(BuildContext context,
      {String providerDescription,
      String providerName,
      String providerAddress,
      String providerState,
      String providerType,
      String activeStatus,
      int providerRating,
      HelperProvider helper}) async {
    ShowDialog(context: context);
    String _token;
    final application = Application.instance();
    await application.getToken("authToken").then((token) {
      _token = token["value"];
    });

    CustomProviderResponse responsePayload = await helper.addCustomProvider(
        authToken: _token,
        errorCallback: errorCallback,
        requestPayload: CustomProviderRequest(
                name: providerName,
                description: providerDescription,
                rating: providerRating,
                address: providerAddress,
                state: providerState,
                activeStatus: activeStatus,
                providerType: providerType)
            .toJson());

    if (responsePayload.name != null) {
      showAlertDialog(context, success: "Successfully added a provider");
    } else {
      ShowSnackBar(
          scaffoldKey: _scaffoldKey, msg: "All fields needs to be completed");
    }
  }
}
