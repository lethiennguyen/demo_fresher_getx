import 'package:demo_fresher_getx/core/base/base.src.dart';
import 'package:demo_fresher_getx/core/base/base_repository_clean/base_repository.dart';
import 'package:demo_fresher_getx/feature/detail/domain/entities/product_entity.dart';
import '../../../../core/base/base_repository/base_api.dart';
import '../../../../lib.dart';
import '../../mapper/mapper.src.dart';
import '../data.src.dart';

class DetailProductSourceImpl extends BaseRepositoryCl
    implements DetailProductDataSources {
  DetailProductMapper mapper;
  DetailProductSourceImpl(this.mapper);

  @override
  Future<ApiResponse> create(ProductRequestEntity entity) async {
    final res = await baseCallApi(
      ApiUrl.products,
      EnumRequestMethod.GET,
      jsonMap: mapper.productDataMapper.mapToData(entity).toJson(),
      isQueryParametersPost: false,
      isToken: true,
    );
    return ApiResponse.fromJson(
      res.data,
      func: (json) => ProductResponse.fromJson(json),
    );
  }

  @override
  Future<ApiResponse> updateProject(ProductRequestEntity entity) async {
    final res = await baseCallApi(
      "${ApiUrl.products}/${entity.id}",
      EnumRequestMethod.GET,
      jsonMap: mapper.productDataMapper.mapToData(entity).toJson(),
      isQueryParametersPost: false,
      isToken: true,
    );
    return ApiResponse.fromJson(
      res.data,
      func: (json) => ProductResponse.fromJson(json),
    );
  }
}
