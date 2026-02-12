import '../../../../core/base/base_reponse/base_response.dart';
import '../domain.src.dart';

abstract class HomeRepository {
  Future<ApiResponseList<ProductEntity>> lisProductItem(
      ListProductRequestEntity entity);

  Future<ApiResponseList<CategoriesEntity>> categories();
  Future<ApiResponse<bool>> deleteProduct(DeleteProductEntity entity);
}
