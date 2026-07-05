class ImageItemsModel {
  String id;
  String url;
  String? thumbUrl;
  bool? isTopRated;
  String? mediaType;
  String? classificationId;
  String? classificationName;
  String? classificationThumbnailUrl;
  String createdAt;
  ImageItemsModel(
    this.id,
    this.url,
    this.thumbUrl,
    this.isTopRated,
    this.mediaType,
    this.classificationId,
    this.classificationName,
    this.classificationThumbnailUrl,
    this.createdAt,
  );
}

class PaginationModel {
  int page;
  int limit;
  int total;
  int totalPages;
  PaginationModel(this.page, this.limit, this.total, this.totalPages);
}

class ImageCategoryData {
  List<ImageItemsModel> items;
  PaginationModel pagination;
  ImageCategoryData(this.items, this.pagination);
}

class ImageCategoryObject {
  ImageCategoryData data;
  ImageCategoryObject(this.data);
}
