import 'package:flutter/material.dart';
import 'package:prozone/screens/add-provider_screen.dart';
import 'package:prozone/screens/screens.dart';
import 'package:prozone/screens/search-options_screen.dart';
import 'package:prozone/screens/update-provider_screen.dart';

/// Defines the route to be supplied to [MaterialApp]
Map<String, WidgetBuilder> getRoutes() {
  return {
    HomeScreen.routeName: (context) => HomeScreen(),
    AddProviderScreen.routeName: (context) => AddProviderScreen(),
    UpdateProviderScreen.routeName: (context) => UpdateProviderScreen(),
    SearchOptionsScreen.routeName: (context) => SearchOptionsScreen()
  };
}