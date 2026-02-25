import 'package:demo_fresher_getx/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';

class FilterListProduct {
  static Widget fillter({
    Widget? body,
    Widget? widgetConfirm,
    VoidCallback? onEdit,
    String? title,
    String? edit,
  }) {
    return Container(
      height: Get.height * 0.4,
      decoration: BoxDecoration(
          color: AppColors.basicWhite,
          border: Border(
            bottom: BorderSide(
              color: AppColors.textColorGrey,
              width: 0.5,
            ),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextUtils(
                text: title ?? "",
                availableStyle: StyleEnum.t16Bold,
              ),
              GestureDetector(
                onTap: onEdit,
                child: Row(
                  children: [
                    TextUtils(
                      text: edit ?? "",
                      color: AppColors.mainColors,
                      availableStyle: StyleEnum.t16Bold,
                    ),
                    sdsSBWidth2,
                    Icon(
                      Icons.edit,
                      color: AppColors.mainColors,
                      size: AppDimens.sizeIconSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          sdsSBHeight15,
          Expanded(child: body ?? SizedBox()),
          sdsSBHeight15,
          widgetConfirm ?? SizedBox(),
          sdsSBHeight15,
        ],
      ).paddingAll(AppDimens.padding16),
    );
  }
}
