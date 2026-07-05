class ListAppModel {
  String id;
  String name;
  String platform;
  List<CategoryModel> categories;
  ListAppModel(this.id, this.name, this.platform, this.categories);
}

class CategoryModel {
  String id;
  String name;
  String type;
  int displayOrder;
  int imageCount;
  CategoryModel(
    this.id,
    this.name,
    this.type,
    this.displayOrder,
    this.imageCount,
  );
}

class HomeListAppModel {
  List<CategoryModel> categories;
  List<ListAppModel> apps;
  HomeListAppModel(this.categories, this.apps);
}

class ListAppObject {
  HomeListAppModel data;
  ListAppObject(this.data);
}
