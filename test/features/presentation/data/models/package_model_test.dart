import 'package:flutter_test/flutter_test.dart';
import 'package:navi_stream/features/presentation/data/models/package_model.dart';

void main() {
  group('PackageModel tests', () {
    const model = PackageModel(
      id: 1,
      purchased: '2024-04-10',
    );

    final json = {
      'id': 1,
      'purchased': '2024-04-10',
    };

    const modelWithNull = PackageModel(
      id: 1,
    );

    final jsonWithNull = {
      'id': 1,
      'purchased': null,
    };

    group('instantiation test', () {
      test('should correctly instantiate with non-null values', () {
        const result = PackageModel(id: 1, purchased: '2024-04-10');

        expect(result, model);
      });

      test('should correctly instantiate with null optional values', () {
        const result = PackageModel(id: 1);

        expect(result, modelWithNull);
      });
    });

    group('serialization tests', () {
      test('should serialize to JSON with optional fields', () {
        final result = model.toJson();

        expect(result, json);
      });

      test('should serialize to JSON with null field', () {
        final result = modelWithNull.toJson();

        expect(result, jsonWithNull);
      });

      test('should deserialize from JSON with optional fields', () {
        final result = PackageModel.fromJson(json);

        expect(result, model);
      });

      test('should deserialize from JSON with null field', () {
        final result = PackageModel.fromJson(json);

        expect(result, model);
      });
    });
  });
}
