import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prozone/models/images_model.dart';
import 'package:prozone/models/provider_model.dart';
import 'package:prozone/utils/consts.dart';

class ProviderItem extends StatelessWidget {
  final List<CustomProvider> providerList;
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
      subtitle: Row(children: getRatings(providerList[index].rating)),
      trailing:
          Icon(Icons.arrow_forward_ios_outlined, size: 16, color: GREEN_HUE),
    );
  }

  List<Widget> getRatings(int rating) {
    final starWidgets = <Widget>[];
    for (var i = 0; i < rating; i++) {
      starWidgets.add(Icon(Icons.star, size: 16, color: GREEN_HUE));
    }
    return starWidgets;
  }

  String getImage(List<Images> images) {
    if (images.length == 0) {
      return null;
    } else {
      final imgUrl = images[0].url;
      return imgUrl;
    }
  }
}
