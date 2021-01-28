import 'package:flutter/material.dart';
import 'package:prozone/enums/enums.dart';
import 'package:prozone/models/customProvider/custom-provider.dart';
import 'package:prozone/models/provider-type_model.dart';
import 'package:prozone/models/state_model.dart';
import 'package:prozone/providers/base_helper.dart';
import 'package:prozone/utils/utils.dart';
import 'package:http/http.dart' as http;

class HelperProvider extends BaseHelper with ChangeNotifier {
  NetworkUtil _netUtil = new NetworkUtil();
  Map<String, String> _headers = {'Content-Type': 'application/json'};
  Map<String, String> _noContentTypeHeader = {};
  Status _activeStatus = Status.all;
  ProviderType _providerType;
  List<ProviderType> _providerTypeList;

  List<ProviderType> get providerTypeList => _providerTypeList;

  set providerTypeList(List<ProviderType> value) {
    _providerTypeList = value;
    notifyListeners();
  }

  Status get activeStatus => _activeStatus;

  set activeStatus(Status value) {
    _activeStatus = value;
    notifyListeners();
  }

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
      final responsePayload =
          await _netUtil.post(url, headers: _headers, body: requestPayload);
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
  Future<List<ProviderType>> getCustomProviderType(
      {String authToken, Function errorCallback}) async {
    const url = BASE_URL + '/provider-types';
    _headers["Authorization"] = "Bearer $authToken";

    String msg;
    try {
      final responsePayload = await _netUtil.getList(url, headers: _headers);
      final providerTypeList = <ProviderType>[];
      for (var data in responsePayload) {
        providerTypeList.add(ProviderType.fromJson(data));
      }
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
  Future<List<CustomState>> getStateList(
      {String authToken, Function errorCallback}) async {
    const url = BASE_URL + '/states';
    _headers["Authorization"] = "Bearer $authToken";

    String msg;
    try {
      final responsePayload = await _netUtil.getList(url, headers: _headers);
      final stateList = <CustomState>[];
      for (var data in responsePayload) {
        stateList.add(CustomState.fromJson(data));
      }
      return stateList;
    } on CustomException catch (e) {
      msg = e.msg == null ? STATE_ERROR_MSG : e.msg;
    } catch (e) {
      msg = e.toString();
    }
    errorCallback(msg);
    throw CustomException(msg: msg);
  }

  @override
  Future<int> addProviderImage(
      {String authToken,
      Map<dynamic, dynamic> requestPayload,
      Function errorCallback}) async {
    const url = BASE_URL + '/upload';
    _noContentTypeHeader["Authorization"] = "Bearer $authToken";

    String msg;
    try {
      final _requestPayload = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(_noContentTypeHeader)
        ..fields["ref"] = requestPayload["ref"]
        ..fields["refId"] = requestPayload["refId"]
        ..fields["field"] = requestPayload["field"];

      for (var i = 0; i < requestPayload["files"].length; i++) {
        _requestPayload.files.add(await http.MultipartFile.fromPath("files", requestPayload["files"][i]));
      }
      final streamedResponse = await _requestPayload.send();
      final response = await http.Response.fromStream(streamedResponse);
      return response.statusCode;
    } on CustomException catch (e) {
      msg = e.msg == null ? PROVIDERS_ERROR_MSG : e.msg;
    } catch (e) {
      msg = e.toString();
    }
    errorCallback(msg);
    throw CustomException(msg: msg);
  }

  ProviderType get providerType => _providerType;

  set providerType(ProviderType value) {
    _providerType = value;
    notifyListeners();
  }
}
