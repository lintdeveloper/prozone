import 'package:flutter/material.dart';
import 'package:prozone/models/provider_model.dart';
import 'package:prozone/providers/base_helper.dart';
import 'package:prozone/utils/utils.dart';

class HelperCustomProvider extends BaseHelper with ChangeNotifier {
  NetworkUtil _netUtil = new NetworkUtil();
  Map<String, String> _headers = {'Content-Type': 'application/json'};

  @override
  Future<List<CustomProvider>> getCustomProviderList(
      {String authToken, Function errorCallback}) async {
    const url = BASE_URL + '/providers';
    _headers["Authorization"] = "Bearer $authToken";

    String msg;
    try {
      final responsePayload = await _netUtil.getList(url, headers: _headers);
      final providersList = <CustomProvider>[];
      for (var data in responsePayload) {
        providersList.add(CustomProvider.fromJson(data));
      }
      print(providersList.length);
      return providersList;
    } on CustomException catch (e) {
      msg = e.msg == null ? PROVIDERS_ERROR_MSG : e.msg;
    } catch (e) {
      msg = e.toString();
    }
    errorCallback(msg);
    throw CustomException(msg: msg);
  }
}
