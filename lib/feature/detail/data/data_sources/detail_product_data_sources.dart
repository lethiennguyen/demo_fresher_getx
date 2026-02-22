import 'package:demo_fresher_getx/core/base/base.src.dart';

import '../../domain/domain.src.dart';

abstract class DetailProductDataSources {
  Future<ApiResponse> updateProject(ProductRequestEntity entity);

  Future<ApiResponse> create(ProductRequestEntity entity);
}
