import 'package:demo_fresher_getx/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';

class FilterListProduct {
  static Widget fillter(
    VoidCallback onTap, {
    Widget? widget,
  }) {
    return Container(
      height: Get.height * 0.5,
      color: AppColors.basicWhite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: widget ?? SizedBox()),
          sdsSBHeight15,
          Row(
            children: [
              Expanded(
                child: ButtonUtils.buildButton(
                  LocaleKeys.button_cancel.tr,
                  onTap,
                  backgroundColor: AppColors.basicWhite,
                  showLoading: true,
                  colorText: AppColors.mainColors,
                  height: AppDimens.btnMedium,
                  borderRadius: BorderRadius.circular(AppDimens.radius12),
                ),
              ),
              sdsSBWidth5,
              Expanded(
                child: ButtonUtils.buildButton(
                  LocaleKeys.button_confirm.tr,
                  onTap,
                  backgroundColor: AppColors.mainColors,
                  showLoading: true,
                  colorText: AppColors.basicWhite,
                  height: AppDimens.btnMedium,
                  borderRadius: BorderRadius.circular(AppDimens.radius12),
                ),
              ),
            ],
          ),
          sdsSBHeight15,
        ],
      ),
    );
  }
}
