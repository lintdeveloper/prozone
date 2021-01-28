import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prozone/models/customProvider/custom-provider.dart';
import 'package:prozone/models/images_model.dart';
import 'package:prozone/utils/consts.dart';
import 'package:prozone/utils/utils.dart';
import 'package:prozone/widget/show-provider_widget.dart';

class ProviderItem extends StatelessWidget {
  final List<CustomProviderResponse> providerList;
  final int index;

  ProviderItem({Key key, @required this.providerList, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String img = getImage(providerList[index].images);
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.black12,
        backgroundImage: img == null ? null : NetworkImage(img),
      ),
      title: Text(providerList[index].name,
          style: TextStyle(fontSize: 16, color: BLUE_HUE)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: getRatings(providerList[index].rating)),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            Icons.api_sharp,
                            color: providerList[index]
                                .activeStatus
                                .toLowerCase() ==
                                "active"
                                ? GREEN_HUE
                                : PINK_HUE,
                            size: 12,
                          )),
                      Text(providerList[index].activeStatus.toUpperCase(),
                          style: TextStyle(fontSize: 10)),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            Icons.apartment_sharp,
                            color: providerList[index]
                                .activeStatus
                                .toLowerCase() ==
                                "active"
                                ? GREEN_HUE
                                : PINK_HUE,
                            size: 12,
                          )),
                      Text(providerList[index].providerType != null
                          ? getProviderTypeName(providerList[index].providerType.name) : "",
                          style: TextStyle(fontSize: 10))
                    ],
                  ),
                  Text(getCreationDate(providerList[index].createdAt),
                      style: TextStyle(fontSize: 10))
                ]),
          )
        ],
      ),
      trailing: GestureDetector(
          onTap: () {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return ShowProviderBottomSheet(providerList[index]);
                });
          },
          child: Icon(Icons.arrow_forward_ios_outlined,
              size: 16, color: GREEN_HUE)),
    );
  }


  String getCreationDate(String createdAt) {
    DateTime dateTime = DateTime.parse(createdAt);
    String month;
    switch (dateTime.month) {
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

  String getImage(List<Images> images) {
    if (images.length == 0) {
      return null;
    } else {
      final imgUrl = images[0].url;
      return imgUrl;
    }
  }

  String getProviderTypeName(String name) {
    return name;
  }
}
