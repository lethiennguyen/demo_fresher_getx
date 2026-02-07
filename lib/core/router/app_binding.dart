import 'package:demo_fresher_getx/core/base/base.src.dart';
import 'package:get/get.dart';

import '../../feature/app/controller/app_controller.dart';
import '../../lib.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {}
}

abstract class BaseBinding implements Bindings {
  @override
  void dependencies() {
    injectRepository();
    injectUseCase();
    injectController();
  }

  void injectRepository();

  void injectUseCase();

  void injectController();
}
