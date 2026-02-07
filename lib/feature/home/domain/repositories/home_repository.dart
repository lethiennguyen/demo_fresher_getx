import '../../../../core/base/base_reponse/base_response.dart';
import '../../../login/domain/entities/login_response_entity.dart';
import '../entities/list_product_request.dart';
import '../entities/product_entity.dart';

abstract class HomeRepository {
  Future<ApiResponse<List<ProductEntity?>>> login(
      ListProductRequestEntity entity);
}
