import 'package:demo_fresher_getx/core/core.src.dart';
import 'package:get/get.dart';
import 'app_controller.dart';

class SplashBinding extends BaseBinding {
  @override
  void dependencies() {
    Get.put<BaseConnectAPI>(BaseConnectAPI(), permanent: true);
  }

  @override
  void injectController() {
    Get.put<AppController>(AppController(), permanent: true);
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
