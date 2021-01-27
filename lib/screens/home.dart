import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:prozone/application.dart';
import 'package:prozone/mixins/index.dart';
import 'package:prozone/models/customProvider/custom-provider.dart';
import 'package:prozone/providers/helper_provider.dart';
import 'package:prozone/screens/add-provider_screen.dart';
import 'package:prozone/screens/provider-list_screen.dart';
import 'package:prozone/utils/consts.dart';
import 'package:prozone/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

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
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 38,
                      margin: EdgeInsets.only(right: 6),
                      width: size.width * .65,
                      decoration: BoxDecoration(
                        color: BLUE_HUE.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                      ),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 4),
                              child: Icon(Icons.search, size: 24, color: BLUE_HUE.withOpacity(0.3),)),
                          Expanded(
                              child: Text(
                            "Search for name or location",
                            style: TextStyle(
                                fontSize: 14, color: BLUE_HUE.withOpacity(0.3)),
                            overflow: TextOverflow.ellipsis,
                          ))
                        ],
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
                      loadImages();
                    },
                    child: Text(
                      'FILTER',
                      style: TextStyle(color: GREEN_HUE, letterSpacing: 2),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder<List<CustomProviderResponse>>(
                    future: getProviderListAction(
                        context: context, helper: _helper),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? ProviderList(customProviderList: snapshot.data)
                          : Container(
                              margin: EdgeInsets.only(top: size.height * 0.40),
                              child:
                                  Center(child: CircularProgressIndicator()));
                    }),
              ),
            ),
          ],
        );
      }),
    );
  }


  Future<void> loadImages() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 7,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          statusBarColor: "#678abc",
          actionBarTitle: "Media",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
          selectionLimitReachedText: "You can't select more than 7",
        ),
      );
    } on NoImagesSelectedException catch (e) {
      print("Cancel");
      print(e);
    } on Exception catch (e) {
      print("DO something");
      print(e);
      // Do something
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      print("Result List");
      print(resultList);
      // sliderImageList = resultList;
      _error = error;
    });
  }

  Future<List<CustomProviderResponse>> getProviderListAction(
      {BuildContext context, HelperProvider helper}) async {
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
