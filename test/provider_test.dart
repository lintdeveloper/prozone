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
import 'package:prozone/models/provider-type_model.dart';
import 'package:prozone/models/provider_model.dart';
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
    ProviderType _providerType = ProviderType(
        id: 2,
        name: "providerType",
        createdAt: _createdDate,
        updatedAt: _createdDate);

      CustomState _state = CustomState(
        id: 2,
        name: "providerType",
        createdAt: _createdDate,
        updatedAt: _createdDate);

    test("CustomProvider serialised to JSON", () async {
      final actual = CustomProvider(
        id: null,
        name: _name,
        description: _description,
        rating: _rating,
        address: _address,
        activeStatus: _activeStatus,
        providerType: _providerType,
        state: _state,
      ).toJson();

      final matcher = {
        "id": null,
        "name": _name,
        "description": _description,
        "rating": _rating,
        "address": _address,
        "activeStatus": _activeStatus,
        "providerType": _providerType,
        "state":_state,
        "createdAt": null,
        "updatedAt": null,
        "images": null
      };
      expect(actual, matcher);
    });

    test("CustomProvider serialised from JSON", () async {
      ProviderType mockCustomProvider = ProviderType(
        id: 1,
        name: "type-1",
        createdAt: _createdDate,
        updatedAt: _updateAt
      );
      CustomState _customState = CustomState(
          id: 1,
          name: "state-1",
          createdAt: _createdDate,
          updatedAt: _updateAt);

      final Map<String, dynamic> json = {
        "id": _id,
        "name": _name,
        "description": _description,
        "rating": _rating,
        "address": _address,
        "activeStatus": _activeStatus,
        "providerType": {
          "id": 1,
          "name": "type-1",
          "createdAt": _createdDate,
          "updatedAt": _updateAt
        },
        "state": {
          "id": 1,
          "name": "state-1",
          "createdAt": _createdDate,
          "updatedAt": _updateAt
        },
        "images": [{
          "id": 1,
          "name":"img-1",
          "url": "url-1",
          "createdAt": _createdDate,
          "updatedAt": _updateAt
        }],
        "createdAt": _createdDate,
        "updatedAt": _updateAt
      };

      final actual = CustomProvider.fromJson(json);
      final matcher = CustomProvider(
          id: _id,
          name: _name,
          description: _description,
          rating: _rating,
          address: _address,
          providerType: mockCustomProvider,
          activeStatus: _activeStatus,
          state: _customState,
          images: mockImages,
          createdAt: _createdDate,
          updatedAt: _updateAt,
      );

      expect(actual, matcher);
    });
  });
}
