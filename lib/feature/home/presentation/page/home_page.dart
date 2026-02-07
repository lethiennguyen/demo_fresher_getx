import 'package:demo_fresher_getx/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/base/widget_base/base_get_page.dart';
import '../../../../core/core.src.dart';
import '../../../../lib.dart';
import '../controller/home_controller.dart';

part 'home_widget.dart';

class HomePage extends BaseGetPage<HomeController> {
  HomePage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: UtilWidget.buildAppBar("Danh sách",
          textColor: AppColors.mainColors,
          showBackButton: false,
          actions: [
            buildIconButton(
              Assets.ASSETS_ICONS_IC_USER_SELECTED_SVG,
              () => Get.offAllNamed(AppRouter.routerLogin),
            )
          ]),
      body: buildHomeBody(controller),
    );
  }
}
