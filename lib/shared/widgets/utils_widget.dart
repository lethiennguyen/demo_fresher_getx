import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo_fresher_getx/shared/shares.src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker_plus/picker.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:badges/badges.dart' as badges;

import '../../generated/locales.g.dart';
import '../../lib.dart';

class UtilWidget {
  static Widget buildLoading({
    Color? colorIcon,
  }) {
    return CupertinoActivityIndicator(
      color: colorIcon ?? AppColors.primaryColor,
    );
  }

  static const Widget shrink = SizedBox.shrink();
  static Widget sizedBox4 = SizedBox(height: 4.h);
  static Widget sizedBox0 = SizedBox(height: 0.h);
  static Widget sizedBox5 = SizedBox(height: 5.h);
  static Widget sizedBox7 = SizedBox(height: 7.h);
  static Widget sizedBox8 = SizedBox(height: 8.h);
  static Widget sizedBox10 = SizedBox(height: 10.h);
  static Widget sizedBox12 = SizedBox(height: 12.h);
  static Widget sizedBox16 = SizedBox(height: 16.h);
  static Widget sizedBox20 = SizedBox(height: 20.h);
  static Widget sizedBox24 = SizedBox(height: 24.h);

  static Widget sizedBoxWidth5 = SizedBox(width: 5.w);
  static Widget sizedBoxWidth8 = SizedBox(width: 8.w);
  static Widget sizedBoxWidth10 = SizedBox(width: 10.w);
  static Widget sizedBoxWidth12 = SizedBox(width: 12.w);
  static Widget sizedBoxWidth16 = SizedBox(width: 16.w);
  static Widget sizedBoxWidth20 = SizedBox(width: 20.w);
  static Widget sizedBoxWidth25 = SizedBox(width: 25.w);
  static DateTime? _dateTime;
  static int? _oldFunc;

  /// Sử dụng để tránh trường hợp click liên tiếp khi thực hiện function
  static Widget baseOnAction({required Function onTap, required Widget child}) {
    return InkWell(
      onTap: () {
        DateTime now = DateTime.now();
        if (_dateTime == null ||
            now.difference(_dateTime ?? DateTime.now()) > 1.seconds ||
            onTap.hashCode != _oldFunc) {
          _dateTime = now;
          _oldFunc = onTap.hashCode;
          onTap();
        }
      },
      child: child,
    );
  }

  /// Loading cho child
  static Widget baseShowLoadingChild({
    required WidgetCallback child,
    required bool isShowLoading,
    Color? colorIcon,
  }) {
    return isShowLoading
        ? Center(child: buildLoading(colorIcon: colorIcon))
        : child();
  }

  static Widget itemCard({
    required Widget child,
    Function? onTap,
    double? vertical,
    double? horizontal,
    Color? borderColor,
    Color? color,
    double? borderRadius,
  }) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Card(
        color: color ?? AppColors.backgroundColorWhite,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          // side: BorderSide(
          //   color: borderColor ?? AppColors.colorBorderSide2,
          //   width: 1.0,
          // ),
          borderRadius:
              BorderRadius.circular(borderRadius ?? AppDimens.paddingVerySmall),
        ),
        child: child.paddingSymmetric(
          horizontal: horizontal ?? AppDimens.defaultPadding,
          vertical: vertical ?? 0,
        ),
      ),
    );
  }

  static Widget buildSmartRefresherCustomFooter(
      {double? heightFooter, Widget? customLoading}) {
    return CustomFooter(
      height: heightFooter ?? 60,
      builder: (context, mode) {
        if (mode == LoadStatus.loading) {
          return customLoading ?? const CupertinoActivityIndicator();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  ///CardBase
  static Widget buildCardBase(
    Widget child, {
    Color? colorBorder,
    Color? backgroundColor,
    double? radius,
    Gradient? gradient,
  }) =>
      Container(
        decoration: BoxDecoration(
          gradient: gradient,
          color: backgroundColor ?? Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(radius ?? AppDimens.radius8)),
          border: Border.all(
            color: colorBorder ?? Colors.transparent,
          ),
        ),
        child: child,
      );

  static Widget buildSolidButton({
    required String title,
    VoidCallback? onPressed,
    double? width,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    BorderSide? side,
    Color? colorText,
  }) {
    return SizedBox(
      width: width,
      height: height ?? 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side: side ?? BorderSide.none,
            borderRadius:
                BorderRadius.circular(borderRadius ?? AppDimens.radius4),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: TextUtils(
            text: title,
            availableStyle: StyleEnum.t16Bold,
            textAlign: TextAlign.center,
            color: colorText ?? AppColors.colorBlack,
            maxLine: 20,
          ),
        ),
      ),
    );
  }

  /// base item bottomSheet
  static Widget buildBottomSheetItem({
    IconData? icon, // Đổi thành nullable (không bắt buộc)
    String? svgPath, // Thêm tham số đường dẫn SVG
    required String label,
    required VoidCallback onTap,
    Color color = AppColors.colorBlack,
  }) {
    return InkWell(
      onTap: () {
        Get.back();
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimens.padding16, horizontal: AppDimens.padding8),
        child: Row(
          children: [
            if (svgPath != null)
              SvgPicture.asset(
                svgPath,
                width: AppDimens.sizeIcon24,
                height: AppDimens.sizeIcon24,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              )
            else if (icon != null)
              Icon(icon, color: color, size: AppDimens.sizeIcon24)
            else
              const SizedBox(width: AppDimens.sizeIcon24),
            UtilWidget.sizedBoxWidth12,
            TextUtils(
              text: label,
              color: color,
              availableStyle: StyleEnum.t16Bold,
            )
          ],
        ),
      ),
    );
  }

  static Widget buildCircleName(String name,
      {double size = 40,
      Color backgroundColor = AppColors.primaryColor,
      Color textColor = AppColors.colorWhite,
      double fontSize = 16}) {
    String initials = '';
    List<String> nameParts = name.split(' ');
    if (nameParts.isNotEmpty) {
      initials += nameParts.first[0];
      if (nameParts.length > 1) {
        initials += nameParts.last[0];
      }
    }

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: backgroundColor,
      child: Text(
        initials.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget taskStatusChip(
      {required String title, Color? backgroundColor, Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: AppTextStyle.font12Bo.copyWith(
          color: textColor ?? AppColors.colorWhite,
        ),
      ),
    );
  }

  static Widget buildBackButton({
    required String title,
    VoidCallback? onPressed,
    double? width,
    double? height,
    double? borderRadius,
    double? borderSide,
    bool isBorderSide = false,
    Color? borderColor,
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
  }) {
    return SizedBox(
      width: width,
      height: height ?? 44,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.colorWhite,
          side: isBorderSide
              ? BorderSide(
                  color: borderColor ?? AppColors.mainColors,
                  width: borderSide ?? 1,
                )
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? AppDimens.radius4),
          ),
        ),
        onPressed: onPressed,
        child: TextUtils(
          text: title,
          availableStyle: StyleEnum.t16Bold,
          textAlign: TextAlign.center,
          color: textColor ?? AppColors.colorBlack,
          maxLine: 20,
        ),
      ),
    );
  }

  static Future<void> showBaseImageSourceBottomSheet({
    required BuildContext context,
    required VoidCallback onTakePhoto,
    required VoidCallback onTakeCamera,
    required VoidCallback onPickFromGallery,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.basicWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimens.radius16),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: AppDimens.padding12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: AppDimens.btnMediumTbSmall,
                    height: AppDimens.padding4,
                    decoration: BoxDecoration(
                      color: AppColors.basicGrey1,
                      borderRadius: BorderRadius.circular(AppDimens.radius8),
                    ),
                  ),
                ),
                sdsSBHeight12,
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const TextUtils(
                    text: 'Chụp ảnh từ Camera',
                    color: AppColors.basicBlack,
                    availableStyle: StyleEnum.t14Bold,
                  ),
                  onTap: onTakeCamera,
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const TextUtils(
                    text: 'Chụp ảnh',
                    color: AppColors.basicBlack,
                    availableStyle: StyleEnum.t14Bold,
                  ),
                  onTap: onTakePhoto,
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const TextUtils(
                    text: 'Lấy từ thư viện',
                    color: AppColors.basicBlack,
                    availableStyle: StyleEnum.t14Bold,
                  ),
                  onTap: onPickFromGallery,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget baseBottomSheet({
    required String title,
    required Widget body,
    Widget? iconTitle,
    bool isSecondDisplay = false,
    bool isMiniSize = false,
    double? paddingPage,
    double? miniSizeHeight,
    Function()? onPressed,
    Function()? onCancel,
    Widget? actionArrowBack,
    double? padding,
    double? paddingBottom,
    bool noAppBar = false,
    Color? backgroundColor,
    TextAlign? textAlign,
    double? maxWidth,
    AlignmentGeometry? alignment,
    bool isHeightMin = false,
    String? headerTitle,
    StyleEnum? styleEnum,
    bool? isShowHeader = true,
  }) {
    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.only(
        top: Get.mediaQuery.padding.top + (isSecondDisplay ? 100 : 20),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: paddingPage ?? AppDimens.paddingVerySmall,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.colorWhite,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppDimens.paddingMedium),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              noAppBar
                  ? const SizedBox()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: AppColors.basicGrey3, width: 0.8),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          TextUtils(
                            text: title,
                            availableStyle: styleEnum ?? StyleEnum.t20Bold,
                          ),
                          Positioned(
                            right: 0,
                            child: InkWell(
                              onTap: onCancel ?? () => Get.back(),
                              child: const Icon(Icons.close, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
              isMiniSize
                  ? Flexible(
                      child: SizedBox(
                        height: isHeightMin
                            ? null
                            : (miniSizeHeight ?? Get.height / 2),
                        child: body,
                      ),
                    )
                  : Flexible(
                      fit: FlexFit.loose,
                      child: body,
                    ),
            ],
          ).paddingSymmetric(
            horizontal: padding ?? 0,
          ),
        ),
      ).paddingOnly(
        bottom: paddingBottom ?? 0,
      ),
    );
  }

  static Widget buildDropdown<T>({
    required List<T> items,
    required String Function(T) display,
    T? selectedItem,
    ValueChanged<T?>? onChanged,
    double height = 50,
    String? hintText,
    double? radius,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius:
            BorderRadius.all(Radius.circular(radius ?? AppDimens.radius8)),
        border: Border.all(color: AppColors.dsGray4),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.defaultPadding,
          ),
          child: DropdownButton<T>(
            dropdownColor: AppColors.colorWhite,
            isExpanded: true,
            selectedItemBuilder: (context) => items.map(
              (e) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    display(e),
                    style: AppTextStyle.font14Re,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                );
              },
            ).toList(),
            items: items
                .map(
                  (e) => DropdownMenuItem<T>(
                    value: e,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimens.paddingVerySmall),
                      child: Text(
                        display(e),
                        style: selectedItem == e
                            ? AppTextStyle.font14Bo
                            : AppTextStyle.font14Re,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                      //   TextUtils(
                      // text: display(e),
                      // availableStyle: selectedItem == e
                      //     ? StyleEnum.bodyBold
                      //     : StyleEnum.bodyRegular,
                      //   maxLine: 2,
                      //   textAlign: TextAlign.start,
                      // ),
                    ),
                  ),
                )
                .toList(),
            value: selectedItem,
            onChanged: onChanged,
            hint: hintText != null
                ? Text(
                    hintText,
                    style: AppTextStyle.font14Re.copyWith(
                      color: AppColors.dsGray3,
                    ),
                    maxLines: 2,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  static Widget baseCard({
    Widget child = const SizedBox(),
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    double borderRadius = AppDimens.borderRadiusMed,
    double? width,
    double? height,
    VoidCallback? onTap,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
  }) {
    Widget content = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(AppDimens.paddingVerySmall),
      decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.colorWhite,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          boxShadow: boxShadow),
      child: child,
    );

    if (onTap != null) {
      content = InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }

  static Widget baseCardWithDivider({
    required List<Widget> children,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    double borderRadius = AppDimens.borderRadiusBig,
    double? width,
    double? height,
    VoidCallback? onTap,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
    Color dividerColor = AppColors.backgroundGrey,
    double dividerHeight = 1,
    EdgeInsetsGeometry dividerPadding =
        const EdgeInsets.symmetric(horizontal: 12),
  }) {
    final content = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ??
          const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingVerySmall,
              vertical: AppDimens.paddingSmall),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.colorWhite,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: boxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildChildrenWithDivider(
          children,
          dividerColor,
          dividerHeight,
          dividerPadding,
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }

  static List<Widget> _buildChildrenWithDivider(
    List<Widget> children,
    Color dividerColor,
    double dividerHeight,
    EdgeInsetsGeometry dividerPadding,
  ) {
    final widgets = <Widget>[];

    for (int i = 0; i < children.length; i++) {
      widgets.add(children[i]);

      if (i != children.length - 1) {
        widgets.add(
          Padding(
            padding: dividerPadding,
            child: Divider(
              height: 16,
              thickness: dividerHeight,
              color: dividerColor,
            ),
          ),
        );
      }
    }

    return widgets;
  }

  static Widget buildHeader({String? title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextUtils(
          text: title ?? "",
          color: AppColors.colorBlack,
          size: AppDimens.sizeTextMediumTb,
          fontWeight: FontWeight.w600,
        ),
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.clear),
        ),
      ],
    );
  }

  static Widget buildHeader2(
      {String? title,
      double? textSize,
      FontWeight? fontWeight,
      Color? textColor,
      Color? color,
      double? border}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.grey2,
            width: border ?? 0.0,
          ),
        ),
        color: color ?? AppColors.basicWhite,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextUtils(
            text: title ?? "",
            color: textColor ?? AppColors.colorBlack,
            size: textSize ?? AppDimens.sizeTextMediumTb,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
    );
  }

// Base Drop Bottom Sheet có OBX
  static Widget baseDropDownBottomSheet({
    String? title,
    Rx<String>? value,
    Function? onTap,
    Color? backgroundColor,
    Color? textColor,
    Color? textColorLabel,
    Color? borderColor,
    Widget? icon,
    double? width,
    double? height,
    double? borderRadius,
    StyleEnum? styleEnum,
    bool isTitle = true,
  }) {
    return UtilWidget.baseCard(
      //padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isTitle
              ? TextUtils(
                  text: title ?? "",
                  color: textColorLabel ?? AppColors.colorBlack,
                  availableStyle: StyleEnum.t16Bold,
                )
              : const SizedBox(),
          sdsSBHeight8,
          InkWell(
            onTap: () {
              onTap?.call();
            },
            child: Container(
              height: height ?? 50.mulSF,
              width: width ?? Get.width,
              decoration: BoxDecoration(
                color: backgroundColor ?? AppColors.basicWhite,
                borderRadius: BorderRadius.circular(
                    borderRadius ?? AppDimens.borderRadiusBigger),
                border: Border.all(
                    color: borderColor ?? AppColors.grey2,
                    style: BorderStyle.solid),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // Icon(
                        //   icon,
                        //   color: iconColor,
                        // ),
                        icon ?? const SizedBox(),
                        sdsSBWidth8,
                        Obx(
                          () => TextUtils(
                            text: value?.value ?? "",
                            availableStyle: styleEnum ?? StyleEnum.t16Regular,
                            color: textColor ?? AppColors.basicBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, size: AppDimens.sizeIcon24),
                ],
              ).paddingSymmetric(horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }

  static Widget baseDropDownBottomSheetFilter({
    String? title,
    String? value,
    Function? onTap,
    Color? backgroundColor,
    Color? textColor,
    Color? textColorLabel,
    Color? iconColor,
    Color? borderColor,
    Widget? icon,
    double? width,
    double? height,
    double? borderRadius,
    StyleEnum? styleEnum,
    bool isTitle = true,
  }) {
    return UtilWidget.baseCard(
      //padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isTitle
              ? TextUtils(
                  text: title ?? "",
                  color: textColorLabel ?? AppColors.colorBlack,
                  availableStyle: StyleEnum.t16Bold,
                )
              : const SizedBox(),
          sdsSBHeight8,
          InkWell(
            onTap: () {
              onTap?.call();
            },
            child: Container(
              height: height ?? 50.mulSF,
              width: width ?? Get.width,
              decoration: BoxDecoration(
                color: backgroundColor ?? AppColors.basicGrey5,
                borderRadius: BorderRadius.circular(
                    borderRadius ?? AppDimens.borderRadiusBigger),
                border: Border.all(
                    color: borderColor ?? AppColors.grey2,
                    style: BorderStyle.solid,
                    width: 0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // Icon(
                        //   icon,
                        //   color: iconColor,
                        // ),
                        icon ?? const SizedBox(),
                        sdsSBWidth8,
                        TextUtils(
                          text: value ?? "",
                          availableStyle: styleEnum ?? StyleEnum.t16Regular,
                          color: textColor ?? AppColors.basicBlack,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: AppDimens.sizeIcon24,
                    color: iconColor ?? AppColors.basicBlack,
                  ),
                ],
              ).paddingSymmetric(horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }

  // Base app bar sliver
  // static Widget baseSliverAppBar({
  //   required Widget cardAppBar,
  //   required Widget body,
  //   Widget? appBAr,
  //   String? title,
  //   double? expandedHeight,
  //   double? borderRadius,
  //   double? elevation,
  //   Color? backgroundColor,
  //   Color? colorCard,
  //   bool? floating,
  //   bool? pinned,
  //   bool? snap,
  //   bool isBack = false,
  //   bool isTitle = false,
  // }) {
  //   final radius = borderRadius ?? 6.0;
  //   return CustomScrollView(
  //     physics: const ClampingScrollPhysics(),
  //     slivers: [
  //       SliverAppBar(
  //         expandedHeight: expandedHeight ?? 150,
  //         pinned: pinned ?? true,
  //         floating: floating ?? false,
  //         snap: snap ?? false,
  //         backgroundColor: backgroundColor ?? AppColors.secondaryOrange1,
  //         shadowColor: AppColors.grey,
  //         elevation: elevation ?? 0,
  //         automaticallyImplyLeading: isBack,
  //         // toolbarHeight: Get.height * 0.2,
  //         shape: RoundedRectangleBorder(
  //             borderRadius:
  //                 BorderRadius.vertical(bottom: Radius.circular(radius))),
  //         flexibleSpace: LayoutBuilder(
  //           builder: (context, constraints) {
  //             double percent = ((constraints.maxHeight - kToolbarHeight) /
  //                     (120 - kToolbarHeight))
  //                 .clamp(0.0, 1.0);
  //             return FlexibleSpaceBar(
  //               collapseMode: CollapseMode.parallax,
  //               title: percent < 0.6
  //                   ? isTitle
  //                       ? appBAr
  //                       : TextUtils(
  //                           text: title ?? "",
  //                           color: Colors.white,
  //                           availableStyle: StyleEnum.t20Bold,
  //                         )
  //                   : null,
  //               background: Stack(
  //                 fit: StackFit.expand,
  //                 children: [
  //                   Container(
  //                     decoration: BoxDecoration(
  //                         color: colorCard ?? AppColors.secondaryOrange1,
  //                         borderRadius: BorderRadius.vertical(
  //                             bottom: Radius.circular(radius))),
  //                   ),
  //                   Positioned(
  //                     left: 0,
  //                     right: 0,
  //                     bottom: 8,
  //                     child: cardAppBar,
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //       // Body content
  //       SliverList(
  //         delegate: SliverChildListDelegate(
  //           [
  //             body,
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
  static Widget baseSliverAppBar({
    required Widget cardAppBar,
    required Widget body,
    Widget? appBAr,
    String? title,
    double? expandedHeight,
    double? collapsedHeight,
    double? borderRadius,
    double? elevation,
    Color? backgroundColor,
    Color? colorCard,
    bool? floating,
    bool? pinned,
    bool? snap,
    bool isBack = false,
    bool isTitle = false,
  }) {
    final radius = borderRadius ?? 0.0;
    final double collapsed = collapsedHeight ?? kToolbarHeight;

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: expandedHeight ?? 150,
          collapsedHeight: collapsed,
          pinned: pinned ?? true,
          floating: floating ?? false,
          snap: snap ?? false,
          backgroundColor: backgroundColor ?? AppColors.secondaryOrange1,
          shadowColor: AppColors.grey,
          elevation: elevation ?? 0,
          automaticallyImplyLeading: isBack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(radius),
            ),
          ),
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              double percent = ((constraints.maxHeight - collapsed) /
                      ((expandedHeight ?? 150) - collapsed))
                  .clamp(0.0, 1.0);

              return FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                title: percent < 0.6
                    ? SafeArea(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: isTitle
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => Get.back(),
                                      icon: const Icon(Icons.arrow_back,
                                          color: AppColors.colorBlack),
                                    ),
                                    TextUtils(
                                      text: title ?? "",
                                      color: Colors.white,
                                      availableStyle: StyleEnum.t20Bold,
                                    ),
                                  ],
                                )
                              : appBAr ?? const SizedBox(),
                        ),
                      )
                    : null,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorCard ?? AppColors.secondaryOrange1,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(radius),
                        ),
                      ),
                    ),

                    /// card bên dưới
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 8,
                      child: cardAppBar,
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        /// body
        SliverList(
          delegate: SliverChildListDelegate(
            [
              body,
            ],
          ),
        ),
      ],
    );
  }

  static Widget buildSearch({
    required TextEditingController textEditingController,
    String? hintSearch,
    required Function function,
    required RxBool isClear,
    Color? hintColor,
    Color? borderColor,
    bool? autofocus,
    Color? backgroundColor,
    double? padding,
  }) {
    hintSearch ??= LocaleKeys.util_text_hintSearch.tr;
    return UtilWidget.buildTextInput(
      height: AppDimens.sizeDialogNotiIcon,
      controller: textEditingController,
      hintText: hintSearch,
      textColor: AppColors.textColor(),
      hintColor: hintColor ?? AppColors.hintTextColor(),
      borderColor: borderColor ?? AppColors.textColorWhite,
      autofocus: autofocus,
      fillColor: backgroundColor ?? AppColors.textColorWhite,
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      onChanged: (v) {
        function();
        isClear.value = textEditingController.text.isNotEmpty;
      },
      prefixIcon: const Icon(
        Icons.search,
        color: AppColors.mainColors,
        size: AppDimens.sizeIconMedium,
      ),
      suffixIcon: Obx(() => Visibility(
            visible: isClear.value,
            child: IconButton(
              onPressed: () {
                textEditingController.clear();
                isClear.value = false;
                function();
              },
              icon: const Icon(
                Icons.clear,
                color: AppColors.mainColors,
              ),
            ).paddingOnly(bottom: AppDimens.paddingSmall),
          )),
    ).paddingSymmetric(vertical: padding ?? AppDimens.paddingSmall);
  }

  static Widget buildTextInput({
    var height,
    Color? textColor,
    String? hintText,
    Color? hintColor,
    Color? fillColor,
    TextEditingController? controller,
    Function(String)? onChanged,
    Function()? onTap,
    Widget? prefixIcon,
    Widget? suffixIcon,
    FocusNode? focusNode,
    Color? borderColor,
    bool? autofocus,
    BorderRadius? borderRadius,
  }) {
    return SizedBox(
      height: height,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        focusNode: focusNode,
        autofocus: autofocus ?? true,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontSize: AppDimens.sizeTextMediumTb,
        ),
        decoration: InputDecoration(
            hoverColor: Colors.white,
            prefixIcon: prefixIcon,
            fillColor: fillColor,
            filled: true,
            suffixIcon: suffixIcon,
            hintText: hintText ?? "",
            hintStyle: TextStyle(
              color: hintColor ?? Colors.black,
              fontSize: AppDimens.sizeTextMediumTb,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.grey),
              borderRadius: borderRadius ??
                  const BorderRadius.all(
                    Radius.circular(5),
                  ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.grey),
              borderRadius: borderRadius ??
                  const BorderRadius.all(
                    Radius.circular(5),
                  ),
            ),
            contentPadding: const EdgeInsets.all(10)),
        onChanged: onChanged,
        onTap: onTap,
        controller: controller,
      ),
    );
  }

  static Widget buildRichText({
    required List<String> children,
    Color? textColor,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextStyle? Function(TextStyle? style, int index)? styleBuilder,
    GestureRecognizer? Function(int index)? recognizerBuilder,
  }) {
    final style = Get.textTheme.bodySmall?.copyWith(
      color: textColor,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      decoration: decoration,
      overflow: overflow ?? TextOverflow.ellipsis,
      fontSize: fontSize ?? AppDimens.fontSmall14(),
    );
    return AutoSizeText.rich(
      textAlign: textAlign,
      TextSpan(
        text: children.first,
        recognizer: recognizerBuilder?.call(0),
        style: styleBuilder?.call(style, 0) ?? style,
        children: List.generate(
          children.length - 1,
          (index) {
            final text = children[index + 1];
            return TextSpan(
              text: text.tr,
              style: styleBuilder?.call(style, index + 1) ?? style,
              recognizer: recognizerBuilder?.call(index + 1),
            );
          },
        ),
      ),
    );
  }

  static Widget buildText(
    String text, {
    FontWeight? fontWeight,
    TextAlign? textAlign,
    Color? textColor,
    int? maxLines,
    double? fontSize,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextStyle? textStyle,
  }) {
    return AutoSizeText(
      text.tr,
      maxLines: maxLines,
      textAlign: textAlign,
      style: textStyle ??
          Get.textTheme.bodySmall?.copyWith(
            color: textColor,
            fontWeight: fontWeight,
            overflow: overflow ?? TextOverflow.ellipsis,
            fontSize: fontSize ?? AppDimens.fontSmall14(),
            fontStyle: fontStyle,
            decoration: decoration,
          ),
    );
  }

  static PreferredSizeWidget buildAppBar(String title,
      {Color? textColor,
      Color? actionsIconColor,
      Color? backButtonColor,
      Color? backgroundColor,
      bool centerTitle = false,
      Function()? funcLeading,
      Widget? leading,
      List<Widget>? actions,
      bool isColorGradient = false,
      List<Color>? colorTransparent,
      bool automaticallyImplyLeading = false,
      bool showBackButton = true,
      StyleEnum? styleEnum,
      PreferredSizeWidget? widget}) {
    return AppBar(
      bottom: widget,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actionsIconTheme:
          IconThemeData(color: actionsIconColor ?? AppColors.textColorWhite),
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.textColorWhite,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      title: TextUtils(
        text: title,
        color: textColor ?? AppColors.textColorWhite,
        availableStyle: styleEnum ?? StyleEnum.t20Bold,
      ).paddingOnly(left: 10),
      centerTitle: centerTitle,
      titleSpacing: 0,
      leading: leading ??
          (showBackButton // Chỉ hiển thị nút back khi showBackButton = true
              ? IconButton(
                  onPressed: funcLeading ??
                      () {
                        Get.back();
                      },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: backButtonColor ?? AppColors.basicWhite,
                  ),
                )
              : null),
      flexibleSpace: isColorGradient
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: colorTransparent ?? AppColors.colorHeadPayroll,
                ),
              ),
            )
          : null,
      actions: actions,
      backgroundColor:
          isColorGradient ? null : backgroundColor ?? AppColors.colorWhite,
      scrolledUnderElevation: 0,
      // không đổi khi scroll
      surfaceTintColor: Colors.transparent,
      // bỏ lớp tint
      elevation: 0,
      // tùy, nếu không muốn bóng
      shadowColor: Colors.transparent,
    );
  }

  static Future<DateTime?> timePickerUtils(
    String initialDate, {
    bool requireDate = false,
  }) async {
    DateTime? time;
    final value = initialDate.isNullOrEmpty
        ? DateTime.now()
        : convertStringToDate(initialDate, pattern13);

    /// UI chọn giờ phút
    final picker = Picker(
      adapter: DateTimePickerAdapter(
        customColumnType: [3, 4],
        value: value,
      ),
      looping: true,
      hideHeader: true,
      itemExtent: Get.height * 0.04,
      selectedTextStyle: const TextStyle(
        color: AppColors.lightSecondColor,
        fontWeight: FontWeight.bold,
        fontSize: AppDimens.sizeTextMedium,
      ),
      selectionOverlay: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppDimens.padding14),
        decoration: BoxDecoration(
          color: AppColors.orangeHighlight,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusBig),
        ),
      ),
    );

    await Get.bottomSheet(
      UtilWidget.baseBottomSheet(
        title: '',
        noAppBar: true,
        isMiniSize: true,
        miniSizeHeight: Get.height * 0.4,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildHeaderTimePicker(title: LocaleKeys.util_text_timeText),
            UtilWidget.sizedBox20,
            picker.makePicker(),
            const Spacer(),
            ButtonUtils.buildButton(
              'Xác nhận',
              () {
                time = DateTime.parse(picker.adapter.toString());
                Get.back();
              },
              width: Get.width * 0.9,
              backgroundColor: AppColors.mainColors,
            ),
          ],
        ),
      ),
    );
    return time == null
        ? null
        : !requireDate
            ? DateTime(1, 1, 1, time!.hour, time!.minute, 0, 0, 0)
            : DateTime(value.year, value.month, value.day, time!.hour,
                time!.minute, 0, 0, 0);
  }

  static Widget buildHeaderTimePicker({String? title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UtilWidget.buildText(
          title ?? "",
          textColor: AppColors.colorBlack,
          fontSize: AppDimens.sizeTextMediumTb,
          fontWeight: FontWeight.w600,
        ),
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.clear),
        ),
      ],
    );
  }

  static Future<DateTime?> buildDateTimePicker({
    DateTime? dateTimeInit,
    DateTime? minTime,
    DateTime? maxTime,
  }) async {
    return showRoundedDatePicker(
      context: Get.context!,
      height: 320,
      initialDate: dateTimeInit,
      firstDate: minTime,
      lastDate: maxTime ?? limitedTime(),
      textPositiveButton: LocaleKeys.util_text_accept.tr,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.deepOrange,
        primaryColor: AppColors.appBarColor(),
        disabledColor: AppColors.hintTextColor(),
        dialogBackgroundColor: AppColors.dateTimeColor(),
        textTheme: TextTheme(
          bodySmall: Get.textTheme.bodyLarge,
          labelLarge: Get.textTheme.bodyLarge?.copyWith(
            color: AppColors.hintTextColor(),
          ),
        ),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        textStyleMonthYearHeader: Get.textTheme.bodyLarge,
        colorArrowNext: AppColors.hintTextColor(),
        colorArrowPrevious: AppColors.hintTextColor(),
        paddingMonthHeader: const EdgeInsets.all(
          AppDimens.defaultPadding,
        ),
        textStyleButtonNegative: Get.textTheme.bodyLarge?.copyWith(
          color: AppColors.hintTextColor(),
        ),
        textStyleButtonPositive: Get.textTheme.bodyLarge?.copyWith(
          color: AppColors.linkText(),
        ),
      ),
    );
  }

  static Future<DateTime?> buildDateTime({
    DateTime? dateTimeInit,
    DateTime? minTime,
    DateTime? maxTime,
  }) async {
    return showRoundedDatePicker(
      context: Get.context!,
      height: 300,
      initialDate: dateTimeInit,
      firstDate: minTime ?? DateTime.now(),
      lastDate: maxTime ?? limitedTime(),
      textPositiveButton: LocaleKeys.util_text_accept.tr,
      theme: ThemeData(
        primaryColor: AppColors.mainColors,
        colorScheme: const ColorScheme.light(
          primary: AppColors.mainColors, // header + selected day
          onPrimary: Colors.white, // text trên header
          surface: Colors.white, // background
          onSurface: Colors.black, // text ngày
        ),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        backgroundPicker: Colors.white,
        textStyleButtonNegative: const TextStyle(
          color: AppColors.listTaskIconGrey, // Màu bạn muốn cho nút Hủy
          fontWeight: FontWeight.bold,
        ),
        textStyleDayOnCalendar: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        textStyleDayButton: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textStyleYearButton: const TextStyle(
          color: Colors.white,
        ),
        decorationDateSelected: const BoxDecoration(
          color: AppColors.mainColors, // ngày được chọn
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  static Widget buildSelectionBottomSheet<T>({
    required String title,
    required List<T> items,
    required bool Function(T) checkSelected, // Sử dụng function để check
    required String Function(T) itemTitleMapper,
    required Function(T) onItemSelected,
    required VoidCallback onConfirm,
  }) {
    return UtilWidget.baseBottomSheet(
      title: title,
      isMiniSize: true,
      isHeightMin: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...items.asMap().entries.expand((entry) {
            final index = entry.key;
            final item = entry.value;

            return [
              if (index == 0) sdsSBHeight3,
              if (index != 0) dividerBase02,
              Obx(() => _buildItem(
                    title: itemTitleMapper(item),
                    isSelected: checkSelected(item),
                    onTap: () => onItemSelected(item),
                  )),
              sdsSBHeight3,
              dividerBase02,
            ];
          }),
          sdsSBHeight20,
          ButtonUtils.buildButton(
            LocaleKeys.my_task_confirm.tr,
            onConfirm,
            backgroundColor: AppColors.mainColors,
          ),
          sdsSBHeight20,
        ],
      ),
    );
  }

  static Widget _buildItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return UtilWidget.baseCard(
      onTap: onTap,
      height: AppDimens.height45,
      borderRadius: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextUtils(
              text: title,
              availableStyle: StyleEnum.t16Bold,
              color: AppColors.basicBlack,
            ),
          ),
          if (isSelected) const Icon(Icons.check, color: AppColors.mainColors),
        ],
      ),
    );
  }

  static Widget badgeCount({required int count, bool isNotification = false}) {
    var position = badges.BadgePosition.topEnd(
      top: -10,
      end: count >= 10
          ? count > 99
              ? -10
              : -12
          : -8,
    );
    if (isNotification) {
      position = badges.BadgePosition.topEnd(
        top: -4,
        end: count >= 10
            ? count > 99
                ? -10
                : -6
            : 2,
      );
    }
    return badges.Badge(
      showBadge: count > 0,
      badgeStyle: count > 99
          ? badges.BadgeStyle(
              badgeColor: AppColors.statusRed,
              shape: badges.BadgeShape.square,
              borderRadius: BorderRadius.circular(AppDimens.radius20),
            )
          : const badges.BadgeStyle(
              badgeColor: AppColors.statusRed,
            ),
      badgeAnimation: const badges.BadgeAnimation.scale(),
      position: position,
      badgeContent: count > 0
          ? Center(
              child: TextUtils(
                text: count > 99 ? '99+' : count.toString(),
                availableStyle: StyleEnum.t12Bold,
                color: AppColors.basicWhite,
              ),
            )
          : null,
    );
  }
//
// static Widget buildBanner({
//   required Widget child,
//   VoidCallback? onTap,
// }) {
//   return SingleChildScrollView(
//     child: Column(
//       children: [
//         Container(
//           height: Get.height,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(AppDimens.sizeBorderNavi),
//             ),
//             image: DecorationImage(
//               image: AssetImage(
//                 Assets.ASSETS_IMAGES_IMG_BANNER_PNG,
//               ),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Stack(
//             children: [
//               // Align(
//               //     alignment: Alignment.topCenter,
//               //     child: ImageAppExt.imageIconAndNameApp()
//               //         .paddingOnly(top: AppDimens.sizeBottomNavi80.h)),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   UtilWidget.itemCard(
//                     horizontal: 0,
//                     child: child.paddingAll(AppDimens.defaultPadding),
//                     onTap: () {
//                       KeyBoard.hide();
//                       onTap?.call();
//                     },
//                   ).paddingSymmetric(horizontal: AppDimens.padding24),
//                 ],
//               ).paddingOnly(
//                 top: AppDimens.btnMediumTb.h,
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
}

Widget baseLinearProgress({
  String? title,
  double? value, // 0 -> 1
  Color? color,
  Color? backgroundColor,
  double? minHeight,
  bool isShowValue = true,
}) {
  return Row(
    children: [
      // Title bên trái
      if (title != null)
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: UtilWidget.buildText(title,
                fontSize: AppDimens.fontSmall(),
                fontWeight: FontWeight.bold,
                textColor: AppColors.colorBlack),
          ),
        ),
      // ProgressBar
      Expanded(
        flex: 3,
        child: Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: value,
                minHeight: minHeight ?? 10,
                borderRadius: BorderRadius.circular(6),
                backgroundColor: backgroundColor ?? Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  color ?? AppColors.blue,
                ),
              ),
            ),
            if (isShowValue)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: UtilWidget.buildText(
                  '${((value ?? 0) * 100).toStringAsFixed(0)}%',
                  fontSize: AppDimens.fontSmall(),
                  fontWeight: FontWeight.w900,
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

class DashedLine extends StatelessWidget {
  const DashedLine({
    super.key,
    this.color = const Color(0xFFCCCCCC),
    this.strokeWidth = 1,
    this.dashWidth = 6,
    this.dashGap = 4,
    this.axis = Axis.horizontal,
  });

  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: axis == Axis.horizontal
          ? Size(double.infinity, strokeWidth)
          : Size(strokeWidth, double.infinity),
      painter: _DashedLinePainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashGap: dashGap,
        axis: axis,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashGap,
    required this.axis,
  });

  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final Axis axis;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (axis == Axis.horizontal) {
      final y = size.height / 2;
      double startX = 0;
      while (startX < size.width) {
        final endX = startX + dashWidth;
        canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);
        startX += dashWidth + dashGap;
      }
    } else {
      final x = size.width / 2;
      double startY = 0;
      while (startY < size.height) {
        final endY = startY + dashWidth;
        canvas.drawLine(Offset(x, startY), Offset(x, endY), paint);
        startY += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BaseCheckbox extends StatelessWidget {
  const BaseCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.labelStyle,
    this.size = 20,
    this.activeColor,
    this.inactiveBorderColor,
    this.disabledColor,
    this.padding = const EdgeInsets.all(4),
    this.spacing = 8,
    this.borderRadius = 4,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  final String? label;
  final TextStyle? labelStyle;

  final double size;
  final Color? activeColor;
  final Color? inactiveBorderColor;
  final Color? disabledColor;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final double borderRadius;

  bool get _enabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color active = activeColor ?? AppColors.mainColors;
    final Color inactiveBorder = inactiveBorderColor ?? theme.dividerColor;
    final Color disabled = disabledColor ?? theme.disabledColor;

    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // thu nhỏ hitbox của Checkbox về đúng size mình
          SizedBox(
            width: size,
            height: size,
            child: Theme(
              data: theme.copyWith(
                checkboxTheme: theme.checkboxTheme.copyWith(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  // ignore: deprecated_member_use
                  side: MaterialStateBorderSide.resolveWith((states) {
                    // ignore: deprecated_member_use
                    if (states.contains(MaterialState.disabled)) {
                      return BorderSide(color: disabled, width: 1.5);
                    }
                    // ignore: deprecated_member_use
                    if (states.contains(MaterialState.selected)) {
                      return BorderSide(color: active, width: 1.5);
                    }
                    return BorderSide(color: inactiveBorder, width: 1.5);
                  }),
                ),
              ),
              child: Checkbox(
                value: value,
                onChanged: (v) {
                  if (_enabled) {
                    onChanged!(v!);
                  }
                },
                activeColor: active,
                checkColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
          if (label != null) SizedBox(width: spacing),
          if (label != null)
            Flexible(
              child: GestureDetector(
                onTap: _enabled ? () => onChanged!(!value) : null,
                child: Text(
                  label!,
                  style: labelStyle ??
                      theme.textTheme.bodyMedium?.copyWith(
                        color: _enabled
                            ? theme.textTheme.bodyMedium?.color
                            : disabled,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget buildBaseRadioButton<T>({
  required T value,
  required T? groupValue,
  required ValueChanged<T?>? onChanged,
  String? label,
  double size = 20,
  double spacing = 8,
  EdgeInsetsGeometry padding = const EdgeInsets.all(4),
  Color? activeColor,
  Color? inactiveBorderColor,
  Color? disabledColor,
}) {
  return Builder(
    builder: (context) {
      final theme = Theme.of(context);
      final Color active = activeColor ?? AppColors.primaryCam1;
      final Color inactive = inactiveBorderColor ?? theme.dividerColor;
      final Color disabledC = disabledColor ?? theme.disabledColor;
      // ignore: unnecessary_null_comparison
      final bool enabled = onChanged != null;

      return InkWell(
        onTap: enabled ? () => onChanged(value) : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IgnorePointer(
                child: SizedBox(
                  width: size,
                  height: size,
                  child: Theme(
                    data: theme.copyWith(
                      radioTheme: theme.radioTheme.copyWith(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        // ignore: deprecated_member_use
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          // ignore: deprecated_member_use
                          if (states.contains(MaterialState.disabled)) {
                            return disabledC;
                          }
                          // ignore: deprecated_member_use
                          if (states.contains(MaterialState.selected)) {
                            return active;
                          }
                          return inactive;
                        }),
                      ),
                    ),
                    child: Radio<T>(
                      value: value,
                      groupValue: groupValue,
                      onChanged: (_) {},
                      activeColor: active,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ),
              if (label != null) SizedBox(width: spacing),
              if (label != null)
                Flexible(
                  child: TextUtils(
                    text: label,
                    availableStyle: StyleEnum.t14Bold,
                    color:
                        enabled ? theme.textTheme.bodyMedium?.color : disabledC,
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}
