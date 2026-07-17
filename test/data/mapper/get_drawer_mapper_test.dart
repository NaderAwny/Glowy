import 'package:flutter_test/flutter_test.dart';
import 'package:glowy/data/mapper/get_drawer_mapper.dart';
import 'package:glowy/data/responses/get_drawer_data_responses/get_drawer_data_response.dart';
import 'package:glowy/data/responses/list_app_responses/list_app.dart';

void main() {
  group('GetDrawerMapper', () {
    test("maps a full Category to CategoryDrawerModel", () {
      //arrange
      final category = Category("c1", "Nature", "IMAGE", 1, 20);

      //act
      final model = category.toDomain();
      //assert
      expect(model.id, 'c1');
      expect(model.name, 'Nature');
      expect(model.type, 'IMAGE');
      expect(model.displayOrder, 1);
      expect(model.imageCount, 20);
    });

    test("returns default values when fields are null", () {
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

    test("maps a full DrawerApp to DrawerAppModel", () {
      //arrange
      final app = DrawerApp(
        id: "id",
        name: "name",
        description: "description",
        platform: "platform",
        about: "about",
        privacyPolicy: "privacyPolicy",
        termsOfUse: "termsOfUse",
        androidShareLink: "androidShareLink",
        iphoneShareLink: "iphoneShareLink",
        contactEmail: "contactEmail",
        categories: [Category("id", "name", "type", 1, 1)],
      );
      //act
      final model = app.toDomain();
      //assert
      expect(model.id, "id");
      expect(model.name, "name");
      expect(model.description, "description");
      expect(model.platform, "platform");
      expect(model.about, "about");
      expect(model.privacyPolicy, "privacyPolicy");
      expect(model.termsOfUse, "termsOfUse");
      expect(model.androidShareLink, "androidShareLink");
      expect(model.iphoneShareLink, "iphoneShareLink");
      expect(model.contactEmail, "contactEmail");
      expect(model.categories.length, 1);
      expect(model.categories.first.id, 'id');
      expect(model.categories.first.name, 'name');
      expect(model.categories.first.type, 'type');
      expect(model.categories.first.displayOrder, 1);
      expect(model.categories.first.imageCount, 1);
    });

    test("returns default values when fields are null", () {
      //arrange
      final app = DrawerApp(
        id: null,
        name: null,
        description: null,
        platform: null,
        about: null,
        privacyPolicy: null,
        termsOfUse: null,
        androidShareLink: null,
        iphoneShareLink: null,
        contactEmail: null,
        categories: null,
      );
      //act
      final model = app.toDomain();
      //assert
      expect(model.id, '');
      expect(model.name, '');
      expect(model.description, '');
      expect(model.platform, '');
      expect(model.about, '');
      expect(model.privacyPolicy, '');
      expect(model.termsOfUse, '');
      expect(model.androidShareLink, '');
      expect(model.iphoneShareLink, '');
      expect(model.contactEmail, '');
      expect(model.categories.length, 0);
    });

    test("maps a full GetDrawerDataResponse to DrawerAppObject", () {
      //arrange
      final response = GetDrawerDataResponse(
        success: true,
        message: "message",
        data: GetDrawerDataResponseData(
          app: DrawerApp(
            id: "id",
            name: "name",
            description: "description",
            platform: "platform",
            about: "about",
            privacyPolicy: "privacyPolicy",
            termsOfUse: "termsOfUse",
            androidShareLink: "androidShareLink",
            iphoneShareLink: "iphoneShareLink",
            contactEmail: "contactEmail",
            categories: [Category("id", "name", "type", 1, 1)],
          ),
        ),
      );
      //act
      final result = response.toDomain();
      expect(result.data.apps.id, "id");
      expect(result.data.apps.name, "name");
      expect(result.data.apps.description, "description");
      expect(result.data.apps.platform, "platform");
      expect(result.data.apps.about, "about");
      expect(result.data.apps.privacyPolicy, "privacyPolicy");
      expect(result.data.apps.termsOfUse, "termsOfUse");
      expect(result.data.apps.androidShareLink, "androidShareLink");
      expect(result.data.apps.iphoneShareLink, "iphoneShareLink");
      expect(result.data.apps.contactEmail, "contactEmail");
      expect(result.data.apps.categories.length, 1);
      expect(result.data.apps.categories.first.id, "id");
      expect(result.data.apps.categories.first.name, "name");
      expect(result.data.apps.categories.first.type, "type");
      //assert
      expect(result.data.categories.length, 1);
      expect(result.data.categories.first.id, "id");
      expect(result.data.categories.first.name, "name");
      expect(result.data.categories.first.type, "type");
      expect(result.data.categories.first.displayOrder, 1);
      expect(result.data.categories.first.imageCount, 1);
    });
  });
}
