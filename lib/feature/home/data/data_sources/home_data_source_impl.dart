import 'package:demo_fresher_getx/core/base/base.src.dart';
import 'package:demo_fresher_getx/core/base/base_repository_clean/base_repository.dart';
import 'package:demo_fresher_getx/feature/home/data/model/list_product_response.dart';
import 'package:demo_fresher_getx/feature/home/domain/entities/list_product_request.dart';
import 'package:demo_fresher_getx/feature/home/mapper/home_mapper.dart';
import 'package:demo_fresher_getx/feature/login/data/data_sources/data_sources.src.dart';
import 'package:demo_fresher_getx/feature/login/data/model/login_response_model.dart';
import 'package:demo_fresher_getx/feature/login/domain/domain.src.dart';
import 'package:demo_fresher_getx/feature/login/mapper/login_request_mapper.dart';

import '../../../../core/base/base_repository_clean/base_api.dart';
import '../../../../lib.dart';
import '../../mapper/mapper.src.dart';
import '../data.src.dart';

class HomeDataSourcesImpl extends BaseRepositoryCl implements HomeDataSources {
  ListProductRequestMapper mapper;
  HomeDataSourcesImpl(this.mapper);

  @override
  Future<ApiResponse<ProductItemResponseModel>> lisProductItem(
      ListProductRequestEntity entity) async {
    final res = await baseCallApi(
      ApiUrl.products,
      EnumRequestMethod.GET,
      jsonMap: mapper.mapToData(entity).toJson(),
      isQueryParametersPost: true,
      isToken: false,
    );
    return ApiResponse<ProductItemResponseModel>.fromJson(
      res.data,
      func: (res) => ProductItemResponseModel.fromJson(res),
    );
  }
}
