class DrawerAppModel {
  String id;
  String name;
  String description;
  String platform;
  String about;
  String privacyPolicy;
  String termsOfUse;
  String androidShareLink;
  String iphoneShareLink;
  String contactEmail;
  List<CategoryDrawerModel> categories;
  DrawerAppModel(
    this.id,
    this.name,
    this.description,
    this.platform,
    this.about,
    this.privacyPolicy,
    this.termsOfUse,
    this.androidShareLink,
    this.iphoneShareLink,
    this.contactEmail,
    this.categories,
  );
}

class CategoryDrawerModel {
  String id;
  String name;
  String type;
  int displayOrder;
  int imageCount;
  CategoryDrawerModel(
    this.id,
    this.name,
    this.type,
    this.displayOrder,
    this.imageCount,
  );
}

class DrawerAppDataModel {
  List<CategoryDrawerModel> categories;
  DrawerAppModel apps;
  DrawerAppDataModel(this.categories, this.apps);
}

class DrawerAppObject {
  DrawerAppDataModel data;
  DrawerAppObject(this.data);
}
