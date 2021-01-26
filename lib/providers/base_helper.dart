import 'package:prozone/models/models.dart';

abstract class BaseHelper {
  Future<List<CustomProvider>> getCustomProviderList({String authToken, Function errorCallback});
  Future<List<CustomState>> getStateList({String authToken, Function errorCallback});
  Future<List<ProviderType>> getCustomProviderType({String authToken, Function errorCallback});
}