import 'package:flutter/material.dart';
import 'package:prozone/models/customProvider/custom-provider.dart';
import 'package:prozone/models/provider-type_model.dart';
import 'package:prozone/models/state_model.dart';
import 'package:prozone/providers/base_helper.dart';
import 'package:prozone/utils/utils.dart';

class HelperProvider extends BaseHelper with ChangeNotifier {
  NetworkUtil _netUtil = new NetworkUtil();
  Map<String, String> _headers = {'Content-Type': 'application/json'};

  @override
  Future<List<CustomProviderResponse>> getCustomProviderResponseList(
      {String authToken, Function errorCallback}) async {
    const url = BASE_URL + '/providers';
    _headers["Authorization"] = "Bearer $authToken";

    String msg;
    try {
      final responsePayload = await _netUtil.getList(url, headers: _headers);
      final providersList = <CustomProviderResponse>[];
      for (var data in responsePayload) {
        providersList.add(CustomProviderResponse.fromJson(data));
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

  @override
  Future<CustomProviderResponse> addCustomProvider(
      {String authToken, Map requestPayload, Function errorCallback}) async {
    const url = BASE_URL + '/providers';
    _headers["Authorization"] = "Bearer $authToken";

    String msg;
    try {
      final responsePayload = await _netUtil.post(url, headers: _headers, body: requestPayload);
      return CustomProviderResponse.fromJson(responsePayload);
    } on CustomException catch (e) {
      msg = e.msg == null ? PROVIDERS_ERROR_MSG : e.msg;
    } catch (e) {
      msg = e.toString();
    }
    errorCallback(msg);
    throw CustomException(msg: msg);
  }

  @override
  Future<List<ProviderType>> getCustomProviderType({String authToken, Function errorCallback}) async {
    const url = BASE_URL + '/provider-types';
    _headers["Authorization"] = "Bearer $authToken";

    String msg;
    try {
      final responsePayload = await _netUtil.getList(url, headers: _headers);
      final providerTypeList = <ProviderType>[];
      for (var data in responsePayload) {
        providerTypeList.add(ProviderType.fromJson(data));
      }
      print(providerTypeList.length);
      return providerTypeList;
    } on CustomException catch (e) {
      msg = e.msg == null ? PROVIDER_TYPES_ERROR_MSG : e.msg;
    } catch (e) {
      msg = e.toString();
    }
    errorCallback(msg);
    throw CustomException(msg: msg);
  }

  @override
  Future<List<CustomState>> getStateList({String authToken, Function errorCallback}) async {
    const url = BASE_URL + '/states';
    _headers["Authorization"] = "Bearer $authToken";

    String msg;
    try {
      final responsePayload = await _netUtil.getList(url, headers: _headers);
      final stateList = <CustomState>[];
      for (var data in responsePayload) {
        stateList.add(CustomState.fromJson(data));
      }
      print(stateList.length);
      return stateList;
    } on CustomException catch (e) {
      msg = e.msg == null ? STATE_ERROR_MSG : e.msg;
    } catch (e) {
      msg = e.toString();
    }
    errorCallback(msg);
    throw CustomException(msg: msg);
  }
}
