import 'package:prozone/models/provider_model.dart';

abstract class BaseHelper {
  Future<List<CustomProvider>> getCustomProviderList({String authToken});
}