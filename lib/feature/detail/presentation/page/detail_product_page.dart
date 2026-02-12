import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/base/widget_base/base_get_page.dart';
import '../../../../generated/locales.g.dart';
import '../../../../lib.dart';
import '../../../../shared/widgets/input_form/input.src.dart';
import '../controller/controller.src.dart';

part 'detail_product_widget.dart';
part 'update_product_wiget.dart';

class DetailProductPage extends BaseGetPage<DetailProductController> {
  DetailProductPage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.basicWhite,
      appBar: UtilWidget.buildAppBar(
        "Tạo sản phẩm",
        centerTitle: true,
        backButtonColor: AppColors.basicBlack,
        textColor: AppColors.mainColors,
      ),
      body: _buildBody(controller),
      bottomNavigationBar: buildBottomBar(controller),
    );
  }
}
