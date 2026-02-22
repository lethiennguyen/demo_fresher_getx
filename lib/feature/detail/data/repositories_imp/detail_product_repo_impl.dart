import 'package:demo_fresher_getx/core/base/base_reponse/base_response.dart';
import 'package:demo_fresher_getx/feature/home/data/data.src.dart';
import '../../domain/domain.src.dart';
import '../../mapper/mapper.src.dart';
import '../data.src.dart';

class DetailProductRepoImpl extends DetailProductRepository {
  DetailProductDataSources detailProductDataSources;

  DetailProductRepoImpl(this.detailProductDataSources);

  @override
  Future<ApiResponse> create(ProductRequestEntity entity) async {
    return await detailProductDataSources.create(entity);
  }

  @override
  Future<ApiResponse> updateProject(ProductRequestEntity entity) async {
    return await detailProductDataSources.updateProject(entity);
  }
}
