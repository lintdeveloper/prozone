import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:prozone/application.dart';
import 'package:prozone/mixins/index.dart';
import 'package:prozone/models/customProvider/custom-provider.dart';
import 'package:prozone/models/models.dart';
import 'package:prozone/providers/helper_provider.dart';
import 'package:prozone/utils/consts.dart';
import 'package:prozone/utils/data.dart';
import 'package:prozone/utils/utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddProviderScreen extends StatefulWidget {
  static String routeName = "add-provider";

  @override
  _AddProviderScreenState createState() => _AddProviderScreenState();
}

class _AddProviderScreenState extends State<AddProviderScreen> {
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
      body: ResponsiveSafeArea(builder: (context, size) {
        return Container(
          margin: EdgeInsets.only(top: 20, bottom: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 18,
                    right: 18,
                    bottom: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.arrow_back, color: BLUE_HUE)),
                      Text("Add Provider",
                          style: TextStyle(color: BLUE_HUE, fontSize: 16)),
                      GestureDetector(
                          onTap: () {
                            final form = _formKey.currentState;
                            form.save();

                            if (form.validate()) {
                              if (_providerName == null ||
                                  _providerDescription == null ||
                                  _providerAddress == null ||
                                  _selectedState == null ||
                                  _selectedProviderType == null ||
                                  _selectedActiveStatus == null) {
                                ShowSnackBar(
                                    scaffoldKey: _scaffoldKey,
                                    msg: "All fields needs to be completed");
                              } else if ((_providerRating).round() == 0) {
                                ShowSnackBar(
                                    scaffoldKey: _scaffoldKey,
                                    msg: "Rating can't be 0");
                              } else {
                                addProvider(context,
                                    providerDescription:
                                        _providerDescription.trim(),
                                    providerAddress: _providerAddress.trim(),
                                    providerType: _selectedProviderType.id.toString(),
                                    providerName: _providerName,
                                    activeStatus: _selectedActiveStatus.name,
                                    providerState: _selectedState.id.toString(),
                                    providerRating: (_providerRating).round(),
                                    helper: _helper);
                              }
                            }
                          },
                          child: Icon(Icons.check, color: GREEN_HUE)),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(left: 32, right: 32, top: 12),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 16),
                            child: TextFormField(
                              autofocus: true,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  hintText: "Provider name",
                                  labelText: "Enter provider name",
                                  contentPadding: EdgeInsets.fromLTRB(
                                      16.0, 16.0, 16.0, 16.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(color: GREEN_HUE)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(color: GREEN_HUE)),
                                  filled: false),
                              onSaved: (val) => _providerName = val,
                            ),
                          ),
                          TextFormField(
                            minLines: 2,
                            maxLines: 12,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.multiline,
                            maxLength: 200,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                hintText: "Description",
                                helperText: "Description",
                                labelText: "Enter description",
                                contentPadding:
                                    EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    borderSide: BorderSide(color: GREEN_HUE)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    borderSide: BorderSide(color: GREEN_HUE)),
                                filled: false),
                            onSaved: (val) => _providerDescription = val,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            child: TextFormField(
                              minLines: 2,
                              maxLines: 12,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.multiline,
                              maxLength: 50,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  hintText: "Address",
                                  helperText: "Address",
                                  labelText: "Enter address",
                                  contentPadding: EdgeInsets.fromLTRB(
                                      16.0, 16.0, 16.0, 16.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(color: GREEN_HUE)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(color: GREEN_HUE)),
                                  filled: false),
                              onSaved: (val) => _providerAddress = val,
                            ),
                          ),
                          _customStateList == null
                              ? Container()
                              : Column(
                                  children: [
                                    Container(
                                        margin:
                                            EdgeInsets.only(top: 20, left: 8),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Choose a state",
                                          style: TextStyle(
                                              color: BLUE_HUE.withOpacity(0.7)),
                                        )),
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 14, left: 8),
                                      child:
                                          DropdownButtonFormField<CustomState>(
                                        isExpanded: true,
                                        onChanged: (CustomState state) {
                                          setState(() {
                                            _selectedState = state;
                                          });
                                        },
                                        iconEnabledColor: GREEN_HUE,
                                        value: null,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: BLUE_HUE.withOpacity(0.7)),
                                        items: _customStateList
                                            .map<DropdownMenuItem<CustomState>>(
                                                (CustomState state) {
                                          return DropdownMenuItem<CustomState>(
                                              value: state,
                                              child: Text(state.name));
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                          _providerTypeList == null
                              ? Container()
                              : Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 8),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Choose a provider type",
                                          style: TextStyle(
                                              color: BLUE_HUE.withOpacity(0.7)),
                                        )),
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 14, left: 8),
                                      child:
                                          DropdownButtonFormField<ProviderType>(
                                        isExpanded: true,
                                        onChanged: (ProviderType providerType) {
                                          setState(() {
                                            _selectedProviderType =
                                                providerType;
                                          });
                                        },
                                        iconEnabledColor: GREEN_HUE,
                                        value: null,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: BLUE_HUE.withOpacity(0.7)),
                                        items: _providerTypeList.map<
                                                DropdownMenuItem<ProviderType>>(
                                            (ProviderType providerType) {
                                          return DropdownMenuItem<ProviderType>(
                                              value: providerType,
                                              child: Text(providerType.name));
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                          _providerTypeList == null
                              ? Container()
                              : Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 8),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Choose an active status",
                                          style: TextStyle(
                                              color: BLUE_HUE.withOpacity(0.7)),
                                        )),
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 14, left: 8),
                                      child:
                                          DropdownButtonFormField<ActiveStatus>(
                                        isExpanded: true,
                                        onChanged: (ActiveStatus activeStatus) {
                                          setState(() {
                                            _selectedActiveStatus =
                                                activeStatus;
                                          });
                                        },
                                        iconEnabledColor: GREEN_HUE,
                                        value: null,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: BLUE_HUE.withOpacity(0.7)),
                                        items: activeStatusList.map<
                                                DropdownMenuItem<ActiveStatus>>(
                                            (ActiveStatus activeStatus) {
                                          return DropdownMenuItem<ActiveStatus>(
                                              value: activeStatus,
                                              child: Text(activeStatus.name));
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 8, bottom: 4),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Rate provider",
                                    style: TextStyle(
                                        color: BLUE_HUE.withOpacity(0.7),
                                        fontSize: 16),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: GREEN_HUE,
                                      size: 18,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                      setState(() {
                                        _providerRating = rating;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                          // SizedBox(
                          //   height: BUTTON_HEIGHT,
                          //   width: double.infinity,
                          //   child: RaisedButton(
                          //     color: GREEN_HUE,
                          //     elevation: 0.0,
                          //     onPressed: () async {
                          //       // final form = _formKey.currentState;
                          //       // form.save();
                          //       //
                          //       // if (form.validate()) {
                          //       //   if (_email.isEmpty || _password.isEmpty) {
                          //       //     ShowSnackBar(
                          //       //         scaffoldKey: _scaffoldKey,
                          //       //         msg: "Email or Password can\'t be empty");
                          //       //   } else if (!_email.contains("@")) {
                          //       //     ShowSnackBar(
                          //       //         scaffoldKey: _scaffoldKey,
                          //       //         msg: "Use a valid e-Mail");
                          //       //   } else if (_password.length < 6) {
                          //       //     ShowSnackBar(
                          //       //         scaffoldKey: _scaffoldKey,
                          //       //         msg: "Password can\'t be less than 6 characters");
                          //       //   } else {
                          //       //     loginAction(context: context, auth: _auth, password: _password,
                          //       //         email: _email.toLowerCase().trim());
                          //       //   }
                          //       // }
                          //     },
                          //     child: Text(
                          //       'Login',
                          //       style: TextStyle(
                          //         fontSize: 16,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

    if(responsePayload.name != null){
      showAlertDialog(context, success: "Successfully added a provider");
    } else {
      ShowSnackBar(
          scaffoldKey: _scaffoldKey,
          msg: "All fields needs to be completed");
    }
  }
}
