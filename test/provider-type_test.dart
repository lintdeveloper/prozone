import 'package:flutter_test/flutter_test.dart';
import 'package:prozone/models/models.dart';
import 'package:prozone/models/provider-type_model.dart';
void main() {
  group("Serialisation:", () {
    int _id = 1;
    String _name = "Hospital";
    String _createdDate = DateTime.now().toIso8601String();
    String _updateAt = "2021-01-05T00:00:00.000";

    test("ProviderType serialised from JSON", () async {
      final Map<String, dynamic> json = {
        "id": _id,
        "name": _name,
        "createdAt": _createdDate,
        "updatedAt": _updateAt
      };

      final actual = ProviderType.fromJson(json);
      final matcher = ProviderType(
          id: 1,
          name: "Hospital",
          createdAt: _createdDate,
          updatedAt: _updateAt,
      );

      expect(actual, matcher);
    });
  });
}
