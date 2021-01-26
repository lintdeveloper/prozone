// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:prozone/models/images_model.dart';
import 'package:prozone/models/models.dart';
import 'package:prozone/models/provider-type_model.dart';
import 'package:prozone/models/state_model.dart';

void main() {
  group("Serialisation:", () {
    int _id = 2;
    String _name = "Abuja";
    String _createdDate = DateTime.now().toIso8601String();
    String _updateAt = "2021-01-05T00:00:00.000";

    test("State Response serialised from JSON", () async {
      final Map<String, dynamic> json = {
        "id": _id,
        "name": _name,
        "createdAt": _createdDate,
        "updatedAt": _updateAt
      };

      final actual = CustomState.fromJson(json);
      final matcher = CustomState(
          id: 2,
          name: "Abuja",
          createdAt: _createdDate,
          updatedAt: _updateAt,
      );

      expect(actual, matcher);
    });
  });
}
