import 'package:flutter_test/flutter_test.dart';
import 'package:prozone/models/models.dart';
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
