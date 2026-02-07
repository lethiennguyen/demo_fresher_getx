import 'package:demo_fresher_getx/core/core.src.dart';
import 'package:demo_fresher_getx/feature/home/presentation/controller/controller.src.dart';
import 'package:get/get.dart';

class HomeBinding extends BaseBinding {
  @override
  void injectController() {
    Get.lazyPut(() => HomeController());
  }

  @override
  void injectRepository() {
    // TODO: implement injectRepository
  }

  @override
  void injectUseCase() {
    // TODO: implement injectUseCase
  }
}
