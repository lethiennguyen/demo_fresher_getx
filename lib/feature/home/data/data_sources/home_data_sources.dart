import 'package:demo_fresher_getx/feature/home/domain/entities/list_product_request.dart';

import '../../../../core/base/base.src.dart';
import '../model/list_product_response.dart';

abstract class HomeDataSources {
  Future<ApiResponse<ProductItemResponseModel>> lisProductItem(
      ListProductRequestEntity entity);
}
