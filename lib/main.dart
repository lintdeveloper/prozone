import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:prozone/providers.dart';
import 'package:prozone/root.dart';
import 'package:prozone/router.dart';
import 'package:prozone/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MultiProvider(
      child: App(),
      providers: getProviders()
  ))
  );
}
class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: AppSetter(),
      routes: getRoutes(),
    );
  }
}

