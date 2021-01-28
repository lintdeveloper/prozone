import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:prozone/application.dart';
import 'package:prozone/enums/enums.dart';
import 'package:prozone/mixins/index.dart';
import 'package:prozone/models/customProvider/custom-provider.dart';
import 'package:prozone/models/models.dart';
import 'package:prozone/providers/helper_provider.dart';
import 'package:prozone/screens/add-provider_screen.dart';
import 'package:prozone/screens/provider-list_screen.dart';
import 'package:prozone/utils/consts.dart';
import 'package:prozone/utils/utils.dart';
import 'package:prozone/widget/custom-search-delegate_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  bool isFilter = false;

  bool isAllStatus = true;
  bool isPendingStatus = false;
  bool isActiveStatus = false;
  String _selectedActiveStatus = "All";
  ProviderType _selectedProviderType;

  @override
  void initState() {
    // print()
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _helper = Provider.of<HelperProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: LIGHT_BLUE_ACCENT,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Provider",
          style: TextStyle(color: BLUE_HUE, fontSize: 18),
        ),
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
            )),
      ),
      body: ResponsiveSafeArea(builder: (context, size) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 14),
              child: isFilter
                  ? Container(
                color: LIGHT_GREEN_HUE,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Filters",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFilter = false;
                              });
                            },
                            child: Row(
                              children: [
                                Text("Close ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                                Icon(LineIcons.close, color: GREEN_HUE),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Selected Status :",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Chip(
                              elevation: 2.0,
                              label: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: 20,
                                  child: Center(
                                      child: Text(
                                        _selectedActiveStatus,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ))),
                              backgroundColor: GREEN_HUE,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.greenAccent,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 6),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          ActionChip(
                            elevation: isAllStatus ? 12.0 : 2.0,
                            padding: EdgeInsets.all(2.0),
                            label: Container(
                                width: 40,
                                height: 20,
                                child: Center(
                                    child: Text(
                                      'All',
                                      style: TextStyle(
                                          color: BLUE_HUE,
                                          fontWeight: FontWeight.w400),
                                    ))),
                            onPressed: () {
                              setState(() {
                                _selectedActiveStatus = "All";
                              });
                            },
                            backgroundColor: Colors.grey[200],
                            shape: StadiumBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.greenAccent,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: ActionChip(
                              elevation: isAllStatus ? 12.0 : 2.0,
                              padding: EdgeInsets.all(2.0),
                              label: Container(
                                  width: 60,
                                  height: 20,
                                  child: Center(
                                      child: Text(
                                        'Active',
                                        style: TextStyle(
                                            color: BLUE_HUE,
                                            fontWeight: FontWeight.w400),
                                      ))),
                              onPressed: () {
                                setState(() {
                                  _selectedActiveStatus = "Active";
                                });
                              },
                              backgroundColor: Colors.grey[200],
                              shape: StadiumBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.greenAccent,
                                  )),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            child: ActionChip(
                              elevation: 8.0,
                              padding: EdgeInsets.all(2.0),
                              label: Container(
                                  width: 60,
                                  height: 20,
                                  child: Center(
                                      child: Text(
                                        'Pending',
                                        style: TextStyle(
                                            color: BLUE_HUE,
                                            fontWeight: FontWeight.w400),
                                      ))),
                              onPressed: () {
                                setState(() {
                                  _selectedActiveStatus = "Pending";
                                });
                              },
                              backgroundColor: Colors.grey[200],
                              shape: StadiumBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.greenAccent,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Selected ProviderType :",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Chip(
                              elevation: 2.0,
                              label: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 12),
                                  height: 20,
                                  child: Center(
                                      child: Text(_selectedProviderType == null
                                          ? "All"
                                          : _selectedProviderType.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ))),
                              backgroundColor: GREEN_HUE,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.greenAccent,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 6),
                      child: SingleChildScrollView(
                        child: FutureBuilder<List<ProviderType>>(
                            future: getProviderTypeAction(
                                context: context, helper: _helper),
                            builder: (context, snapshot) {
                              if (snapshot.hasError)
                                print(snapshot.error);
                              return snapshot.hasData
                                  ? Wrap(
                                alignment: WrapAlignment.center,
                                children: getProviderTypes(
                                    snapshot.data),
                              )
                                  : Container(
                                  margin: EdgeInsets.only(
                                      top: size.height * 0.20,
                                      bottom: size.height * 0.20),
                                  child: Center(
                                      child:
                                      CircularProgressIndicator()));
                            }),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ActionChip(
                          elevation: 8.0,
                          padding: EdgeInsets.all(2.0),
                          avatar: CircleAvatar(
                            backgroundColor: GREEN_HUE,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          label: Container(
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              child: Text('Apply')),
                          onPressed: () async {
                            _helper.providerType = _selectedProviderType;
                            _helper.activeStatus = _selectedActiveStatus == "All" ? Status.all
                                : _selectedActiveStatus == "Active"
                                ? Status.active : Status.pending;
                            print ("Filter");
                            setState(() {
                              isFilter = false;
                            });
                            print(_helper.providerType);
                            print(_helper.activeStatus);
                          },
                          backgroundColor: Colors.grey[200],
                          shape: StadiumBorder(
                              side: BorderSide(
                                width: 1,
                                color: GREEN_HUE,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              )
                  : Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 38,
                      margin: EdgeInsets.only(right: 6),
                      width: size.width * .65,
                      decoration: BoxDecoration(
                          color: BLUE_HUE.withOpacity(0.1),
                          borderRadius:
                          BorderRadius.all(Radius.circular(6))),
                      child: GestureDetector(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.search,
                                  size: 24,
                                  color: BLUE_HUE.withOpacity(0.3),
                                )),
                            Expanded(
                                child: Text(
                                  "Search for name or location",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: BLUE_HUE.withOpacity(0.3)),
                                  overflow: TextOverflow.ellipsis,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      side: BorderSide(width: 2, color: GREEN_HUE),
                    ),
                    onPressed: () {
                      isFilter
                          ? setState(() {
                        isFilter = false;
                      })
                          : setState(() {
                        isFilter = true;
                      });
                      print(isFilter);
                    },
                    child: Text(
                      'FILTER',
                      style:
                      TextStyle(color: GREEN_HUE, letterSpacing: 2),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: isFilter
                  ? Container()
                  : SingleChildScrollView(
                child: FutureBuilder<List<CustomProviderResponse>>(
                    future: getProviderListAction(
                        context: context, helper: _helper),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? ProviderList(
                          customProviderList: snapshot.data,
                          scaffoldKey: _scaffoldKey)
                          : Container(
                          margin: EdgeInsets.only(
                              top: size.height * 0.40),
                          child: Center(
                              child: CircularProgressIndicator()));
                    }),
              ),
            ),
          ],
        );
      }),
    );
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

    if ((_helper.activeStatus == Status.all) &&
        (_helper.providerType == null)) {
      return responsePayload;
    }else if ((_helper.activeStatus == Status.all) &&
        (_helper.providerType != null)) {
      return responsePayload
          .where((provider) => provider.providerType == _helper.providerType).toList();
    } else if ((_helper.activeStatus == Status.active) &&
        (_helper.providerType == null)) {
      return responsePayload
          .where((provider) => provider.activeStatus == "Active")
          .toList();
    } else if ((_helper.activeStatus == Status.pending) &&
        (_helper.providerType == null)) {
      return responsePayload
          .where((provider) => provider.activeStatus == "Pending")
          .toList();
    } else if ((_helper.activeStatus == Status.active) &&
        (_helper.providerType != null)) {
      return responsePayload
          .where((provider) => provider.activeStatus == "Active")
          .toList()
          .where((provider) => provider.providerType == _helper.providerType).toList();
    } else if ((_helper.activeStatus == Status.pending) &&
        (_helper.providerType != null)) {
      return responsePayload
          .where((provider) => provider.activeStatus == "Pending")
          .toList()
          .where((provider) => provider.providerType == _helper.providerType).toList();
    }
    return responsePayload;
  }

  Future<List<ProviderType>> getProviderTypeAction(
      {BuildContext context, HelperProvider helper}) async {
    final _helper = Provider.of<HelperProvider>(context);
    String _token;
    final application = Application.instance();
    await application.getToken("authToken").then((token) {
      _token = token["value"];
    });
    List<ProviderType> responsePayload = await helper.getCustomProviderType(
        authToken: _token, errorCallback: errorCallback);

    return responsePayload;
  }

  void errorCallback(String msg) {
    Navigator.of(context).pop();
    ShowSnackBar(scaffoldKey: _scaffoldKey, msg: msg);
  }

  List<Widget> getProviderTypes(List<ProviderType> data) {
    List<Widget> widgets = <Widget>[];

    for (var i = 0; i < data.length; i++) {
      widgets.add(Container(
        margin: EdgeInsets.only(left: 6),
        child: ActionChip(
          elevation: 8.0,
          padding: EdgeInsets.all(2.0),
          label: Container(
              width: 120,
              height: 20,
              child: Center(
                  child: Text(
                    "${data[i].name}",
                    style: TextStyle(
                        fontSize: 12,
                        color: BLUE_HUE,
                        fontWeight: FontWeight.w400),
                  ))),
          onPressed: () {
            setState(() {
              _selectedProviderType = data[i];
            });
          },
          backgroundColor: Colors.grey[200],
          shape: StadiumBorder(
              side: BorderSide(
                width: 1,
                color: Colors.greenAccent,
              )),
        ),
      ));
    }

    widgets.add(Container(
      margin: EdgeInsets.only(left: 6),
      child: ActionChip(
        elevation: 8.0,
        padding: EdgeInsets.all(2.0),
        label: Container(
            width: 120,
            height: 20,
            child: Center(
                child: Text(
                  "All",
                  style: TextStyle(
                      fontSize: 12,
                      color: BLUE_HUE,
                      fontWeight: FontWeight.w400),
                ))),
        onPressed: () {
          setState(() {
            _selectedProviderType = null;
          });
        },
        backgroundColor: Colors.grey[200],
        shape: StadiumBorder(
            side: BorderSide(
              width: 1,
              color: Colors.greenAccent,
            )),
      ),
    ));
    return widgets;
  }
}
