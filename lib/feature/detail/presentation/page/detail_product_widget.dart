part of 'detail_product_page.dart';

Widget buildDetailItem({
  required String title,
  required String value,
  bool isLast = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextUtils(
        text: title,
        availableStyle: StyleEnum.t14Regular,
        color: AppColors.basicGrey2,
      ),
      sdsSB4,
      TextUtils(
        text: value.isEmpty ? "-" : value,
        availableStyle: StyleEnum.t16Bold,
        color: AppColors.basicBlack,
        maxLine: 2,
      ),
      if (!isLast) ...[
        sdsSBHeight16,
        Divider(
          color: AppColors.basicGrey3,
          height: 1,
        ),
        sdsSBHeight16,
      ]
    ],
  );
}

Widget buildDetailImage(String imageUrl) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.network(
      imageUrl,
      width: double.infinity,
      height: 160,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: double.infinity,
        height: 160,
        color: Colors.grey[200],
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      ),
    ),
  );
}

Widget buildProductDetailBody(DetailProductController controller) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDetailImage(controller.productEntity?.image ?? ""),
        sdsSBHeight20,
        buildDetailItem(
          title: "Tên sản phẩm",
          value: controller.productEntity?.name ?? "",
        ),
        buildDetailItem(
          title: "Mã sản phẩm",
          value: controller.productEntity?.code ?? "",
        ),
        buildDetailItem(
          title: "Giá sản phẩm",
          value: formatCurrency(controller.productEntity?.price),
        ),
        buildDetailItem(
          title: "Số lượng",
          value: controller.productEntity?.stock?.toString() ?? "",
        ),
        buildDetailItem(
          title: "Danh mục",
          value: controller.productEntity?.category?.name ?? "",
          isLast: true,
        ),
      ],
    ).paddingAll(AppDimens.padding16),
  );
}

Widget buildBottomBarDetail(DetailProductController controller) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: AppColors.textColorGrey,
          width: 0.5,
        ),
      ),
      color: AppColors.basicWhite,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: ButtonUtils.buildButton(
            "Xoá",
            () {},
            backgroundColor: AppColors.basicWhite,
            showLoading: true,
            colorText: AppColors.overdueColor,
            height: AppDimens.btnMediumTbSmall,
            border: Border.all(
              color: AppColors.overdueColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(AppDimens.radius12),
          ).paddingAll(AppDimens.padding16),
        ),
        sdsSBWidth5,
        Expanded(
          child: ButtonUtils.buildButton(
            "Sửa",
            () {
              controller.onEditPressed();
            },
            backgroundColor: AppColors.mainColors,
            showLoading: true,
            colorText: AppColors.basicWhite,
            height: AppDimens.btnMediumTbSmall,
            borderRadius: BorderRadius.circular(AppDimens.radius12),
          ).paddingAll(AppDimens.padding16),
        ),
      ],
    ),
  );
}

String formatCurrency(double? price) {
  if (price == null) return "-";
  return "${price.toStringAsFixed(0)} đ";
}
