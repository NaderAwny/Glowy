import 'package:glowy/app/constants.dart';
import 'package:glowy/app/extensions.dart';
import 'package:glowy/data/responses/get_drawer_data_responses/get_drawer_data_response.dart';
import 'package:glowy/data/responses/list_app_responses/list_app.dart';

import 'package:glowy/domain/model/get_drawer_model.dart';

extension DrawerAppResponseMapper on DrawerApp {
  DrawerAppModel toDomain() {
    return DrawerAppModel(
      id?.orEmpty() ?? Constants.empty,
      name?.orEmpty() ?? Constants.empty,
      description?.orEmpty() ?? Constants.empty,
      platform?.orEmpty() ?? Constants.empty,
      about?.orEmpty() ?? Constants.empty,
      privacyPolicy?.orEmpty() ?? Constants.empty,
      termsOfUse?.orEmpty() ?? Constants.empty,
      androidShareLink?.orEmpty() ?? Constants.empty,
      iphoneShareLink?.orEmpty() ?? Constants.empty,
      contactEmail?.orEmpty() ?? Constants.empty,
      categories?.map((c) => c.toDomain()).toList() ?? [],
    );
  }
}

extension CategoryResponseMapper on Category {
  CategoryDrawerModel toDomain() {
    return CategoryDrawerModel(
      id?.orEmpty() ?? Constants.empty,
      name?.orEmpty() ?? Constants.empty,
      type?.orEmpty() ?? Constants.empty,
      displayOrder?.orZero() ?? Constants.zero,
      imageCount?.orZero() ?? Constants.zero,
    );
  }
}

//Marge from GetDrawerDataResponseMapper and GetDrawerResponseMapper to make it more readable
extension GetDrawerMapper on GetDrawerDataResponse? {
  DrawerAppObject toDomain() {
    DrawerAppModel drawerApps = this?.data?.app != null
        ? this!.data!.app!.toDomain()
        : DrawerAppModel("", "", "", "", "", "", "", "", "", "", []);

    List<CategoryDrawerModel> categories =
        (this?.data?.app?.categories?.map((category) => category.toDomain()) ??
                Iterable.empty())
            .cast<CategoryDrawerModel>()
            .toList();

    var data = DrawerAppDataModel(categories, drawerApps);

    return DrawerAppObject(data);
  }
}
