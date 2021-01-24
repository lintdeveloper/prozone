// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:prozone/models/images_model.dart';
import 'package:prozone/models/provider-type_model.dart';
import 'package:prozone/models/provider_model.dart';

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
          name: "Image1",
          createdAt: _createdDate,
          updatedAt: _createdDate,
          url: "imageUrl1"),
      Images(
          id: 2,
          name: "Image2",
          createdAt: _createdDate,
          updatedAt: _createdDate,
          url: "imageUrl2"),
      Images(
          id: 3,
          name: "Image3",
          createdAt: _createdDate,
          updatedAt: _createdDate,
          url: "imageUrl3")
    ];
    ProviderType _providerType = ProviderType(
        id: 2,
        name: "providerType",
        createdAt: _createdDate,
        updatedAt: _createdDate);

    test("Provider serialised to JSON", () async {
      final actual = Provider(
        id: _id,
        name: _name,
        activeStatus: _activeStatus,
        address: _address,
        createdAt: _createdDate,
        description: _description,
        rating: _rating,
        updatedAt: _updateAt,
        images: mockImages,
        providerType: _providerType
      ).toJson();

      final matcher = {
        "id": _id,
        "name": _name,
        "activeStatus": _activeStatus,
        "address": _address,
        "createdAt": _createdDate,
        "description": _description,
        "rating": _rating,
        "updatedAt": _updateAt,
        "images": mockImages,
        "providerType": _providerType
      };
      expect(actual, matcher);
    });
  });
}
