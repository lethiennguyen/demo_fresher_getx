import 'package:demo_fresher_getx/core/base/base_reponse/base_response.dart';
import 'package:demo_fresher_getx/feature/home/data/data.src.dart';
import '../../domain/domain.src.dart';
import '../../mapper/mapper.src.dart';

class DetailProductRepoImpl extends DetailProductRepository {
  HomeDataSources homeDataSources;

  DetailProductRepoImpl(this.homeDataSources);
}
