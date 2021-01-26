import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:prozone/application.dart';
import 'package:prozone/mixins/index.dart';
import 'package:prozone/models/models.dart';
import 'package:prozone/providers/helper_provider.dart';
import 'package:prozone/utils/consts.dart';
import 'package:prozone/utils/utils.dart';

class AddProviderScreen extends StatefulWidget {
  static String routeName = "add-provider";

  @override
  _AddProviderScreenState createState() => _AddProviderScreenState();
}

class _AddProviderScreenState extends State<AddProviderScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ProviderType _selectedProviderType;
  List<ProviderType> _providerTypeList;
  List<CustomState> _customStateList;
  CustomState _selectedState;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() async {
        _providerTypeList = await getProviderTypeAction(context: context);
        _customStateList = await getStatesAction(context: context);
      });
      setState(() {
        _selectedProviderType = _providerTypeList[0];
        _selectedState = _customStateList[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
                      Icon(Icons.check, color: GREEN_HUE),
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
                                // controller: _emailController,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                    hintText: "Provider name",
                                    labelText: "Enter provider name",
                                    contentPadding: EdgeInsets.fromLTRB(
                                        16.0, 16.0, 16.0, 16.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide:
                                            BorderSide(color: GREEN_HUE)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide:
                                            BorderSide(color: GREEN_HUE)),
                                    filled: false)),
                          ),
                          TextFormField(
                            minLines: 2,
                            maxLines: 12,
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.multiline,
                            maxLength: 200,
                            // controller: _emailController,
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
                            // onSaved: (val) => _email = val,
                            // onFieldSubmitted: (v) {
                            //   FocusScope.of(context).requestFocus(focus);
                            // }
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            child: TextFormField(
                              minLines: 2,
                              maxLines: 12,
                              autofocus: true,
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
                              // onSaved: (val) => _email = val,
                              // onFieldSubmitted: (v) {
                              //   FocusScope.of(context).requestFocus(focus);
                              // }
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
                                            _selectedState =
                                                state;
                                          });
                                        },
                                        iconEnabledColor: GREEN_HUE,
                                        value: _customStateList[0],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: BLUE_HUE.withOpacity(0.7)),
                                        items: _customStateList.map<
                                                DropdownMenuItem<CustomState>>(
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
                                        value: _providerTypeList[0],
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
                                          DropdownButtonFormField<ProviderType>(
                                        isExpanded: true,
                                        onChanged: (ProviderType providerType) {
                                          setState(() {
                                            _selectedProviderType =
                                                providerType;
                                          });
                                        },
                                        iconEnabledColor: GREEN_HUE,
                                        value: _providerTypeList[0],
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
}
