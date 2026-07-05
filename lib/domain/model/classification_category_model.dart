class ClassificationModel {
  final String? id;
  final String? name;
  final String? thumbnailUrl;
  final int? itemCount;
  ClassificationModel({this.id, this.name, this.thumbnailUrl, this.itemCount});
}

class ClassificationCategoryModel {
  final List<ClassificationModel>? classification;
  ClassificationCategoryModel({this.classification});
}

class ClassificationCategoryMainModel {
  final ClassificationCategoryModel? data;
  ClassificationCategoryMainModel({this.data});
}
