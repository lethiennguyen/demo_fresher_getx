import 'package:demo_fresher_getx/core/base/base.src.dart';
import 'package:demo_fresher_getx/core/base/base_repository_clean/base_repository.dart';
import 'package:demo_fresher_getx/feature/home/domain/entities/delete_product_entity.dart';
import 'package:demo_fresher_getx/feature/home/domain/entities/list_product_request.dart';

import '../../../../core/base/base_repository_clean/base_api.dart';
import '../../../../lib.dart';
import '../../mapper/mapper.src.dart';
import '../data.src.dart';

class HomeDataSourcesImpl extends BaseRepositoryCl implements HomeDataSources {
  HomeMapper mapper;

  HomeDataSourcesImpl(this.mapper);

  @override
  Future<ApiResponseList<ProductItemResponseModel>> lisProductItem(
      ListProductRequestEntity entity) async {
    final res = await baseCallApi(
      ApiUrl.products,
      EnumRequestMethod.GET,
      jsonMap: mapper.listProductRequestMapper.mapToData(entity).toJson(),
      isQueryParametersPost: true,
      isToken: true,
    );
    return ApiResponseList<ProductItemResponseModel>.fromJson(
      res.data,
      func: (res) => ProductItemResponseModel.fromJson(res),
    );
  }

  @override
  Future<ApiResponseList<CategoriesResponseModel>> categories() async {
    final res = await baseCallApi(
      ApiUrl.categories,
      EnumRequestMethod.GET,
      isToken: true,
    );
    return ApiResponseList<CategoriesResponseModel>.fromJson(
      res.data,
      func: (res) => CategoriesResponseModel.fromJson(res),
    );
  }

  @override
  Future<ApiResponse<bool>> deleteProject(DeleteProductEntity entity) async {
    final res = await baseCallApi(
      "${ApiUrl.delete}/${entity.id}",
      EnumRequestMethod.DELETE,
      jsonMap: mapper.deleteProductsMapper.mapToData(entity).toJson(),
      isToken: true,
    );
    return ApiResponse<bool>.fromJson(res.data);
  }
}
