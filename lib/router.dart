import 'package:flutter/material.dart';
import 'package:prozone/screens/screens.dart';

/// Defines the route to be supplied to [MaterialApp]
Map<String, WidgetBuilder> getRoutes() {
  return {
    HomeScreen.routeName: (context) => HomeScreen()
  };
}