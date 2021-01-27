// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:prozone/models/customProvider/custom-provider.dart';
import 'package:prozone/models/file-upload-request_model.dart';
import 'package:prozone/models/images_model.dart';
import 'package:prozone/models/provider-type_model.dart';
import 'package:prozone/models/state_model.dart';

void main() {
  group("Serialisation:", () {
    int _id = 1;
    String _name = "Musa";
    String _activeStatus = "pending";
    String _address = "28, Ahmadu Bello Way";
    String _createdDate = DateTime.now().toIso8601String();
    String _description = "This is a description";
    int _rating = 6;
    String _updateAt = "2021-01-05T00:00:00.000";

    List<Images> mockImages = [
      Images(
          id: 1,
          name: "img-1",
          url: "url-1",
          createdAt: _createdDate,
          updatedAt: _createdDate)
    ];

    String _providerType = "2";
    String _state = "2";
    List _files = [
      "/data/user/0/com.example.prozone/cache/IMG_1611759555631.png",
      "/data/user/0/com.example.prozone/cache/IMG_1611759555652.png"
    ];

    test("CustomProvider Request serialised to JSON", () async {
      final actual = FileUploadRequest(
          ref: "provider",
          refId: "192",
          field: 'images',
          files: _files
      ).toJson();

      final matcher = {
        "ref": "provider",
        "refId": "192",
        "field": 'images',
        "files": _files
      };
      expect(actual, matcher);
    });
  });
}
