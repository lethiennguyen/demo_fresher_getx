import 'package:demo_fresher_getx/core/core.src.dart';
import 'package:demo_fresher_getx/feature/home/data/data.src.dart';
import 'package:demo_fresher_getx/feature/home/data/repositories_imp/home_repo_impl.dart';
import 'package:demo_fresher_getx/feature/home/domain/repositories/home_repository.dart';
import 'package:demo_fresher_getx/feature/home/presentation/controller/controller.src.dart';
import 'package:get/get.dart';

import '../../data/data.src.dart';
import '../../domain/domain.src.dart';
import '../../domain/use_case/use_case.src.dart';
import '../../mapper/mapper.src.dart';
import '../controller/controller.src.dart';

class DetailProductBinding extends BaseBinding {
  @override
  void injectController() {
    Get.lazyPut(() => DetailProductController(Get.find()));
  }

  @override
  void injectRepository() {
    Get.lazyPut<DetailProductDataSources>(() => DetailProductSourceImpl());
    Get.lazyPut<DetailProductRepository>(
        () => DetailProductRepoImpl(Get.find()));
  }

  @override
  void injectUseCase() {
    Get.lazyPut<DetailProductUseCase>(() => DetailProductUseCase());
  }
}
