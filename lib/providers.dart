import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';
import 'package:prozone/providers/helper_provider.dart';

List<SingleChildWidget> getProviders() {
  return [
    ChangeNotifierProvider(create: (context) => HelperProvider())
  ];
}