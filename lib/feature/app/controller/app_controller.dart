import 'package:get/get.dart';

import 'package:hive/hive.dart';
import '../../../core/core.src.dart';

late Box HIVE_APP;

class AppController extends BaseGetxController {
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initApp();
  }

  Future<void> _initApp() async {
    await Hive.openBox(HiveBoxNames.auth);

    final authBox = await Hive.openBox(HiveBoxNames.auth);
    final token = authBox.get(HiveKeys.token, defaultValue: '');
    await Future.delayed(Duration(milliseconds: 2000));
    Get.offAllNamed(AppRouter.routerLogin);
    if (token != '') {
      Get.offAllNamed(AppRouter.routerHome);
    } else {
      Get.offAllNamed(AppRouter.routerLogin);
    }
  }

  Future<void> setLoggedIn(bool value) async {
    final authBox = Hive.box(HiveBoxNames.auth);
    await authBox.put('isLoggedIn', value);
    isLoggedIn.value = value;
  }
}
