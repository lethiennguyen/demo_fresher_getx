import 'package:demo_fresher_getx/core/core.src.dart';
import 'package:demo_fresher_getx/feature/home/data/data.src.dart';
import 'package:demo_fresher_getx/feature/home/data/repositories_imp/home_repo_impl.dart';
import 'package:demo_fresher_getx/feature/home/domain/repositories/home_repository.dart';
import 'package:demo_fresher_getx/feature/home/presentation/controller/controller.src.dart';
import 'package:get/get.dart';

import '../../domain/domain.src.dart';
import '../../mapper/mapper.src.dart';

class HomeBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut(() =>
        HomeMapper(Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => ListProductRequestMapper());
    Get.lazyPut(() => CategoryMapper());
    Get.lazyPut(() => ProductMapper());
    Get.lazyPut(() => CategoriesDataMapper());
    Get.lazyPut(() => DeleteProductsMapper());
  }

  @override
  void injectController() {
    Get.lazyPut(() => HomeController(Get.find()));
  }

  @override
  void injectRepository() {
    Get.lazyPut<HomeDataSources>(() => HomeDataSourcesImpl(Get.find()));
    Get.lazyPut<HomeRepository>(() => HomeRepoImpl(Get.find(), Get.find()));
  }

  @override
  void injectUseCase() {
    Get.lazyPut(() => HomeUseCase(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => ListProductItemUseCase(Get.find()));
    Get.lazyPut(() => CategoriesUseCase(Get.find()));
    Get.lazyPut(() => DeleteProductUseCase(Get.find()));
  }
}
