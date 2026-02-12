import 'package:demo_fresher_getx/feature/login/domain/domain.src.dart';
import 'package:demo_fresher_getx/feature/login/domain/use_case/login_use_case.dart';
import 'package:demo_fresher_getx/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../core/core.src.dart';
import '../../../../shared/widgets/show_popup.dart';

class LoginController extends BaseGetxController with WidgetsBindingObserver {
  final LoginUseCase useCase;

  LoginController(this.useCase);

  /// TextEditingController
  final TextEditingController passWorkController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  /// Login
  final Rx<FocusNode> userNameFocus = FocusNode().obs;
  final Rx<FocusNode> passwordFocus = FocusNode().obs;

  /// Focus state (Rx)
  final RxBool isTaxFocused = false.obs;
  final RxBool isUserNameFocused = false.obs;

  /// Change URL
  final isUrlFocused = false.obs;
  final isCodeFocused = false.obs;

  @override
  void onInit() {
    super.onInit();
    userNameController.text = "cuongpc10";
    passWorkController.text = "123456";
  }

  void login() async {
    isShowLoading.value = true;
    try {
      final entity = LoginRequestEntity(
        userName: userNameController.text.trim(),
        passWord: passWorkController.text.trim(),
      );
      final response = await useCase.execute(entity);

      if (response.statusCode == 400) {
        ShowPopup.showDiaLogNotifyton(
          LocaleKeys.notification_title,
          response.message!,
          LocaleKeys.button_confirm,
          null,
        );
        return;
      }
      final box = Hive.box(HiveBoxNames.auth);
      box.put(HiveKeys.token, response.data?.accessToken);
      Get.offAllNamed(AppRouter.routerHome);
    } finally {
      isShowLoading.value = false;
    }
  }

  @override
  void onClose() {
    passWorkController.dispose();
    userNameController.dispose();
    super.onClose();
  }
}
