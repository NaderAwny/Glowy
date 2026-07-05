import 'package:glowy/app/constants.dart';
import 'package:glowy/app/extensions.dart';
import 'package:glowy/data/responses/list_app_responses/list_app.dart';
import 'package:glowy/domain/model/list_app_model.dart';

extension ListAppResponseMapper on ListApp {
  ListAppModel toDomain() {
    return ListAppModel(
      id?.orEmpty() ?? Constants.empty,
      name?.orEmpty() ?? Constants.empty,
      platform?.orEmpty() ?? Constants.empty,
      categories?.map((c) => c.toDomain()).toList() ?? [],
    );
  }
}

extension CategoryResponseMapper on Category {
  CategoryModel toDomain() {
    return CategoryModel(
      id?.orEmpty() ?? Constants.empty,
      name?.orEmpty() ?? Constants.empty,
      type?.orEmpty() ?? Constants.empty,
      displayOrder?.orZero() ?? Constants.zero,
      imageCount?.orZero() ?? Constants.zero,
    );
  }
}

//Marge from HomeDataResponseMapper and HomeResponseMapper to make it more readable
extension HomeResponseMapper on HomeResponse? {
  ListAppObject toDomain() {
    List<ListAppModel> listApp =
        (this?.data?.apps?.map((app) => app.toDomain()) ?? Iterable.empty())
            .cast<ListAppModel>()
            .toList();
    List<CategoryModel> categories =
        (this?.data?.categories?.map((category) => category.toDomain()) ??
                Iterable.empty())
            .cast<CategoryModel>()
            .toList();

    if (categories.isEmpty) {
      categories = listApp.expand((app) => app.categories).toList();
    }

    var data = HomeListAppModel(categories, listApp);
    return ListAppObject(data);
  }
}
