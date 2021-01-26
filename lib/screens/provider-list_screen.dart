import 'package:flutter/material.dart';
import 'package:prozone/models/provider_model.dart';
import 'package:prozone/screens/provider-item_screen.dart';

class ProviderList extends StatelessWidget {
  final List<CustomProvider> customProviderList;

  ProviderList({Key key, this.customProviderList}):
      super(key: key);

  @override
  Widget build(BuildContext context) {
    if (customProviderList.length == 0) {
      return Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Center(
          child: Text(
            "No Provider",
            style: TextStyle(
                color: Color.fromRGBO(196, 184, 217, 1), fontSize: 12.0),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: customProviderList.length,
      itemBuilder: (context, index) {
        return ProviderItem(providerList: customProviderList, index: index);
      }
    );
  }
}
