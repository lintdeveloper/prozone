import 'package:prozone/models/customProvider/custom-provider.dart';
import 'package:prozone/models/file-upload-request_model.dart';
import 'package:prozone/models/models.dart';

abstract class BaseHelper {
  Future<List<CustomProviderResponse>> getCustomProviderResponseList({String authToken, Function errorCallback});
  Future<List<CustomState>> getStateList({String authToken, Function errorCallback});
  Future<List<ProviderType>> getCustomProviderType({String authToken, Function errorCallback});
  Future<CustomProviderResponse> addCustomProvider({String authToken, Map requestPayload, Function errorCallback});
  Future<int> addProviderImage({String authToken, Map requestPayload, Function errorCallback});
}