import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:line_icons/line_icons.dart';
import 'package:prozone/models/customProvider/custom-provider.dart';
import 'package:prozone/utils/utils.dart';

class ShowProviderBottomSheet extends StatefulWidget {
  CustomProviderResponse customProviderResponse;

  ShowProviderBottomSheet(this.customProviderResponse);

  @override
  _ShowProviderBottomSheetState createState() =>
      _ShowProviderBottomSheetState();
}

class _ShowProviderBottomSheetState extends State<ShowProviderBottomSheet> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getData();
    });
  }

  Future<void> getData() async {
    // _providerTypeList = await getProviderImages(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        color: LIGHT_BLUE_ACCENT,
        boxShadow: [
          BoxShadow(color: GREEN_HUE, spreadRadius: 3),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 16, bottom: 18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: GREEN_HUE),
                  height: 6,
                  width: 28,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 16, top: 4),
                  child: CircleAvatar(
                      backgroundColor: GREEN_HUE.withOpacity(0.3),
                      radius: 16,
                      child: Icon(LineIcons.edit,
                          color: DARK_GREEN_HUE, size: 22)),
                ),
              )
            ],
          ),
          Divider(color: GREEN_HUE, thickness: 0.5),
          Expanded(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        children: widget.customProviderResponse.images.map((e) {
                          return Container(
                            margin: EdgeInsets.all(8),
                            height: size.height * 0.12,
                            width: size.width * 0.22,
                            decoration: BoxDecoration(
                                color: LIGHT_GREEN_HUE,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://www.exampledomain.com/images/background.jpg'),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                          );
                        }).toList()),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    height: size.height * 0.12,
                    width: size.width * 0.80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: LIGHT_GREEN_HUE,
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        border: Border.all(color: GREEN_HUE)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text(
                          "Add new image",
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 12, bottom: 20),
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Container(
                      padding: EdgeInsets.only(left: 8, right: 4),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.customProviderResponse.name,
                                  style: TextStyle(fontSize: 18)),
                              Text(getCreationDate(widget.customProviderResponse.createdAt),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: BLUE_HUE.withOpacity(0.7)))
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  widget.customProviderResponse.description,
                                  textAlign: TextAlign.justify,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: getRatings(
                                      widget.customProviderResponse.rating),
                                ),
                                Text(widget.customProviderResponse.address,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: BLUE_HUE.withOpacity(0.7))),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "STATUS: ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: BLUE_HUE.withOpacity(0.8)),
                                ),
                                Container(
                                  child: Text(
                                      widget.customProviderResponse
                                                  .activeStatus ==
                                              null
                                          ? "None"
                                          : widget.customProviderResponse
                                              .activeStatus.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: BLUE_HUE.withOpacity(0.7))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  String getCreationDate(String createdAt) {
    DateTime dateTime = DateTime.parse(createdAt);
    String month;
    switch(dateTime.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
    }
    return "${dateTime.day} $month, ${dateTime.year} ";
  }

}

