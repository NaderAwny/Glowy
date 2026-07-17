import 'package:flutter_test/flutter_test.dart';
import 'package:glowy/data/mapper/list_app_mapper.dart';
import 'package:glowy/data/responses/list_app_responses/list_app.dart';

void main() {
  group('ListAppMapper', () {
    test('maps a full Category correctly to CategoryModel', () {
      //arrange
      // the Category Model take 5 arguments id,name,type,displayOrder,imageCount
      final category = Category("c1", "Nature", "IMAGE", 1, 20);
      //act
      final model = category.toDomain();

      //assert
      expect(model.id, category.id);
      expect(model.name, category.name);
      expect(model.type, category.type);
      expect(model.displayOrder, category.displayOrder);
      expect(model.imageCount, category.imageCount);
    });

    test('returns default values when fields are null', () {
      //arrange
      final category = Category(null, null, null, null, null);
      //act
      final model = category.toDomain();
      //assert
      expect(model.id, '');
      expect(model.name, '');
      expect(model.type, '');
      expect(model.displayOrder, 0);
      expect(model.imageCount, 0);
    });
    test('falls back to categories nested inside apps when empty', () {
      //arrange
      final app = ListApp("a1", "Appone", "android", [
        Category("c1", "Nature", "IMAGE", 1, 20),
      ]);
      final response = HomeResponse(
        success: true,
        message: "message",
        data: HomeDataResponse([], [app]),
      );

      //act
      final result = response.toDomain();

      //assert
      expect(result.data.apps.length, 1);
      expect(result.data.categories.length, 1);
      expect(result.data.apps.first.id, 'a1');
      expect(result.data.apps.first.name, 'Appone');
      expect(result.data.apps.first.platform, 'android');
      expect(result.data.apps.first.categories.length, 1);
      expect(result.data.apps.first.categories.first.id, 'c1');
      expect(result.data.apps.first.categories.first.name, 'Nature');
      expect(result.data.apps.first.categories.first.type, 'IMAGE');
      expect(result.data.apps.first.categories.first.displayOrder, 1);
      expect(result.data.apps.first.categories.first.imageCount, 20);
    });
    test('maps a full ListApp correctly to ListAppModel', () {
      //arrange
      final app = ListApp("a1", "Appone", "android", [
        Category("c1", "Nature", "IMAGE", 1, 20),
      ]);
      //act
      final model = app.toDomain();
      //assert
      expect(model.id, 'a1');
      expect(model.name, 'Appone');
      expect(model.platform, 'android');
      expect(model.categories.length, 1);
      expect(model.categories.first.id, 'c1');
    });

    test('returns default values when ListApp fields are null', () {
      //arrange
      final app = ListApp(null, null, null, null);
      //act
      final model = app.toDomain();
      //assert
      expect(model.id, '');
      expect(model.name, '');
      expect(model.platform, '');
      expect(model.categories, isEmpty); // categories == []
    });
  });
}
