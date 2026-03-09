import 'package:demo_fresher_getx/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/base/widget_base/base_get_page.dart';
import '../../../../core/core.src.dart';
import '../../../../generated/locales.g.dart';
import '../../../../lib.dart';
import '../../../../shared/widgets/input_form/input.src.dart';
import '../../../detail/presentation/page/detail_product_page.dart';
import '../component/filter_list_product.dart';
import '../component/skeleton.dart';
import '../controller/home_controller.dart';

part 'home_widget.dart';

class HomePage extends BaseGetPage<HomeController> {
  HomePage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: UtilWidget.buildAppBar(LocaleKeys.home_category.tr,
          textColor: AppColors.basicBlack,
          showBackButton: false,
          actions: [
            buildIconButton(() {
              UtilWidget.showConfirmDialog(
                title: LocaleKeys.menu_logout.tr,
                subtitle: LocaleKeys.menu_contentLogout.tr,
                typeAction: AppConst.actionNotification,
                onCancel: () => Get.back(),
                onConfirm: () {
                  controller.logout();
                },
              );
            }, icon: Icons.login_outlined, isIcon: true)
          ]),
      body: buildHomeBody(controller),
      floatingActionButton: buildFloatingActionButton(controller),
    );
  }
}
