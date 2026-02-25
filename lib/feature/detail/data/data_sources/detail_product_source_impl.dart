import 'package:demo_fresher_getx/core/base/base.src.dart';
import 'package:demo_fresher_getx/core/base/base_repository_clean/base_repository.dart';

import '../../../../core/base/base_repository/base_api.dart';
import '../../../../lib.dart';
import '../../domain/domain.src.dart';
import '../../mapper/mapper.src.dart';
import '../data.src.dart';

class DetailProductSourceImpl extends BaseRepositoryCl
    implements DetailProductDataSources {
  DetailProductMapper mapper;

  DetailProductSourceImpl(this.mapper);

  @override
  Future<ApiResponse> createProduct(ProductRequestEntity entity) async {
    final res = await baseCallApi(
      ApiUrl.products,
      EnumRequestMethod.POST,
      jsonMap: mapper.productDataMapper.mapToData(entity).toJson(),
      isQueryParametersPost: false,
      isToken: true,
    );
    return ApiResponse<bool>.fromJson(
      res.data,
    );
  }

  @override
  Future<ApiResponse<bool>> updateProduct(ProductRequestEntity entity) async {
    final res = await baseCallApi(
      "${ApiUrl.products}/${entity.id}",
      EnumRequestMethod.PUT,
      jsonMap: mapper.productDataMapper.mapToData(entity).toJson(),
      isQueryParametersPost: false,
      isToken: true,
    );
    return ApiResponse<bool>.fromJson(
      res.data,
    );
  }

  @override
  Future<ApiResponse> createCategory(CategoryRequestEntity entity) async {
    final res = await baseCallApi(
      ApiUrl.categories,
      EnumRequestMethod.POST,
      jsonMap: mapper.categoryRequestMapper.mapToData(entity).toJson(),
      isQueryParametersPost: false,
      isToken: true,
    );
    return ApiResponse.fromJson(
      res.data,
    );
  }

  @override
  Future<ApiResponse<bool>> deleteProduct(ProductRequestEntity entity) async {
    final res = await baseCallApi(
      "${ApiUrl.products}/${entity.id}",
      EnumRequestMethod.DELETE,
      isQueryParametersPost: false,
      isToken: true,
    );
    return ApiResponse<bool>.fromJson(res.data);
  }
}
