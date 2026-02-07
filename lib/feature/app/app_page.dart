import 'package:demo_fresher_getx/core/base/widget_base/base_get_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../lib.dart';
import 'controller/app_controller.dart';

class SplashPage extends BaseGetPage<AppController> {
  SplashPage({super.key});
  @override
  AppController get controller => Get.put(AppController());
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Center(
        child: SvgPicture.asset(Assets.ASSETS_ICONS_ICON_APPEAR_EYE_SVG,
            width: 158, height: 37),
      ),
    );
  }
}
