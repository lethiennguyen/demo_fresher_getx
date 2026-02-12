import 'package:demo_fresher_getx/feature/home/data/data.src.dart';
import 'package:demo_fresher_getx/feature/home/domain/entities/delete_product_entity.dart';
import 'package:demo_fresher_getx/feature/home/domain/entities/list_product_request.dart';

import '../../../../core/base/base.src.dart';

abstract class HomeDataSources {
  Future<ApiResponseList<ProductItemResponseModel>> lisProductItem(
      ListProductRequestEntity entity);
  Future<ApiResponseList<CategoriesResponseModel>> categories();
  Future<ApiResponse<bool>> deleteProject(DeleteProductEntity entity);
}
