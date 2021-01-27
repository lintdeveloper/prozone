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
      subtitle: Row(children: getRatings(providerList[index].rating)),
      trailing: GestureDetector(
              onTap: (){
                print(providerList[index]);
                showModalBottomSheet<void> (
                    context: context,
                    builder: (BuildContext context) {
                      return ShowProviderBottomSheet(providerList[index]);
                    }
                );
              },
              child: Icon(Icons.arrow_forward_ios_outlined, size: 16, color: GREEN_HUE)),
    );
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
