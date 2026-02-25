part of 'home_page.dart';

Widget buildHomeBody(HomeController controller) {
  return Column(
    children: [
      _buildFilterStatus(controller),
      sdsSBWidth16,
      Expanded(
        child: Stack(
          children: [
            _buildListProduct(controller),
            Obx(
              () => ClipRect(
                // tránh tràn khi animate
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  offset: controller.showFilter.value
                      ? Offset.zero
                      : const Offset(0, -1), // trượt lên trên
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: controller.showFilter.value ? 1 : 0,
                    child: _buildFilter(controller),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildFilter(HomeController controller) {
  return Obx(
    () => FilterListProduct.fillter(
      title: "Danh mục",
      edit: "Chỉnh sửa",
      onEdit: () {
        controller.editCategory();
      },
      body: _buildBodyFilter(controller),
      widgetConfirm: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.errorCategory.value != '')
            TextUtils(
              text: controller.errorCategory.value,
              color: AppColors.overdueColor,
            ),
          sdsSBHeight16,
          controller.isEditCategory.value
              ? _buildButtonEditCategory(controller)
              : _buildButtonFilter(controller),
        ],
      ),
    ),
  );
}

Widget _buildBodyFilter(HomeController controller) {
  return Obx(() {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 13,
        runSpacing: 13,
        children: [
          ...controller.listCategory.map((item) {
            final selected = controller.categorySelected.value?.id == item.id;

            return GestureDetector(
              onTap: () {
                controller.categorySelected.value =
                    controller.categorySelected.value?.id == item.id
                        ? null
                        : item;

                controller.errorCategory.value = '';
              },
              child: Container(
                height: AppDimens.height35,
                width: AppDimens.sizeIconBig,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selected
                        ? AppColors.mainColors
                        : AppColors.bgKeyBoardbtn,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(AppDimens.radius12),
                  color: selected ? AppColors.basicWhite : AppColors.grey2,
                ),
                child: Center(
                  child: TextUtils(
                    text: item.name ?? '',
                    color:
                        selected ? AppColors.mainColors : AppColors.basicBlack,
                    availableStyle: StyleEnum.t14Bold,
                  ),
                ),
              ),
            );
          }),
          GestureDetector(
            onTap: () {
              controller.showDialogCreateCategory();
            },
            child: UtilWidget.baseCard(
              height: AppDimens.height35,
              width: AppDimens.height45,
              border: Border.all(
                color: AppColors.mainColors,
                width: 0.8,
              ),
              borderRadius: AppDimens.radius12,
              backgroundColor: AppColors.basicWhite,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: AppColors.mainColors,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}

Widget _buildButtonFilter(HomeController controller) {
  return ButtonUtils.buildFooterButtons(
    textCancel: "Thiết lập lại",
    textConfirm: LocaleKeys.button_confirm.tr,
    onCancel: () {
      controller.categorySelected.value = null;
      controller.fillerCategory();
      controller.showFilter.value = false;
    },
    onConfirm: () {
      controller.fillerCategory();
      controller.showFilter.value = false;
    },
  );
}

Widget _buildButtonEditCategory(HomeController controller) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: ButtonUtils.buildButton(
          "Hủy",
          () {
            controller.isEditCategory.value = false;
          },
          backgroundColor: AppColors.basicWhite,
          showLoading: true,
          colorText: AppColors.mainColors,
          height: AppDimens.btnMediumTbSmall,
          width: 40,
          borderRadius: BorderRadius.circular(AppDimens.radius12),
          border: Border.all(color: AppColors.mainColors),
        ),
      ),
      sdsSBWidth60,
      Expanded(
        flex: 6,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ButtonUtils.buildButton(
                LocaleKeys.task_remove.tr,
                () => controller.showDialogDelete(),
                backgroundColor: AppColors.basicWhite,
                colorText: AppColors.overdueColor,
                height: AppDimens.btnMediumTbSmall,
                borderRadius: BorderRadius.circular(AppDimens.radius12),
                border: Border.all(color: AppColors.overdueColor),
              ),
            ),
            sdsSBWidth12,
            Expanded(
              flex: 3,
              child: ButtonUtils.buildButton(
                "Cập nhật",
                () {
                  controller.showDialogUpdateCategory();
                },
                backgroundColor: AppColors.mainColors,
                colorText: AppColors.basicWhite,
                height: AppDimens.btnMediumTbSmall,
                borderRadius: BorderRadius.circular(AppDimens.radius12),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget _buildSkeletonListProduct() {
  return ListView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: 6,
    itemBuilder: (context, index) {
      return ProductSkeletonCard();
    },
  );
}

Widget _buildListProduct(HomeController controller) {
  return Obx(() {
    if (controller.isShowLoading.value) {
      return _buildSkeletonListProduct();
    }
    return UtilWidget.buildSmartRefresher(
      refreshController: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoadMore: controller.onLoadMore,
      enablePullDown: true,
      enablePullUp: controller.enablePullup.value,
      shimmer: ProductSkeletonCard(),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.productList.length +
            (controller.isShowLoading.value ? 1 : 0),
        itemBuilder: (context, index) {
          return _buildProductCard(
            controller.productList[index],
            onTap: () {
              Get.toNamed(AppRouter.routerDetail,
                  arguments: controller.productList[index]);
            },
            onDelete: () async {
              await controller.deleteProduct(
                  id: controller.productList[index].id);
              Get.back();
            },
          ).paddingOnly(
            bottom: AppDimens.padding8,
          );
        },
      ),
    );
  });
}

Widget _buildFilterStatus(HomeController controller) {
  return UtilWidget.baseCard(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: SDSInputWithLabel.buildInputData(
            validator: null,
            heightInput: AppDimens.heightInput,
            textEditingController: controller.inputSearchCtrl,
            currentNode: controller.fcsSearch,
            hintText: LocaleKeys.task_search_task.tr,
            //  iconLeading: const Icon(Icons.search),
            borderRadius: AppDimens.borderRadiusBig,
            paddingBottom: 0,
            isValidate: false,
            isValidateText: false,
            onChanged: (_) {
              controller.onSearchChanged();
            },
          ).paddingSymmetric(vertical: AppDimens.padding2),
        ),
        IconButton(
            onPressed: () {
              controller.showFilter.value = !controller.showFilter.value;
            },
            icon: const Icon(
              size: AppDimens.sizeIconSpinner,
              Icons.filter_alt,
              color: AppColors.mainColors,
            )),
      ],
    ).paddingSymmetric(horizontal: AppDimens.padding6),
  );
}

Widget buildFloatingActionButton(HomeController controller) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(AppRouter.routerDetail);
    },
    child: UtilWidget.baseCard(
      height: AppDimens.sizeIconLargeTB,
      width: AppDimens.sizeIconLargeTB,
      backgroundColor: AppColors.mainColors,
      borderRadius: AppDimens.borderRadius40,
      child: const Icon(
        Icons.add,
        color: AppColors.basicWhite,
      ),
    ),
  );
}

Widget buildIconButton(VoidCallback onTap,
    {String? asset,
    IconData? icon,
    double size = 30,
    EdgeInsets padding = const EdgeInsets.all(8),
    bool isIcon = false}) {
  return IconButton(
    onPressed: onTap,
    padding: padding,
    constraints: const BoxConstraints(),
    icon: isIcon
        ? Icon(
            icon,
            size: size,
            color: AppColors.mainColors,
          )
        : SvgPicture.asset(
            asset!,
            width: size,
            height: size,
          ),
  );
}

Widget _buildProductCard(ProductEntity entity,
    {VoidCallback? onTap, VoidCallback? onDelete}) {
  return UtilWidget.baseCard(
    borderRadius: AppDimens.borderRadius16,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 8,
        spreadRadius: 1,
        offset: const Offset(0, 2),
      ),
    ],
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Ảnh sản phẩm
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              entity.image ?? '',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 90,
                height: 90,
                color: Colors.grey[100],
                child: const Icon(Icons.image_not_supported,
                    color: Colors.grey, size: 32),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // 2. Thông tin chi tiết
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tên sản phẩm
                      TextUtils(
                        text: entity.name ?? '',
                        availableStyle: StyleEnum.t15Bold,
                        maxLine: 1,
                        color: AppColors.textPrimary,
                      ),
                      sdsSBHeight4,

                      // Mô tả
                      TextUtils(
                        text: entity.description ?? '',
                        availableStyle: StyleEnum.t12Regular,
                        color: AppColors.grey,
                        maxLine: 2,
                      ),
                      sdsSBHeight8,

                      // Giá
                      TextUtils(
                        text: formatCurrency(entity.price),
                        availableStyle: StyleEnum.t15Bold,
                        color: AppColors.mainColors,
                      ),
                      sdsSBHeight4,

                      Row(
                        children: [
                          Icon(Icons.inventory_2_outlined,
                              size: 13, color: AppColors.grey),
                          sdsSBWidth4,
                          TextUtils(
                            text: "Kho: ${entity.stock ?? 0}",
                            availableStyle: StyleEnum.t12Regular,
                            color: AppColors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Nút xóa
                buildIconButton(
                  () {
                    UtilWidget.showConfirmDialog(
                      title: LocaleKeys.add_tasks_delete_task.tr,
                      subtitle: LocaleKeys.add_tasks_confirm_delete_task.tr,
                      typeAction: AppConst.actionNotification,
                      onCancel: () => Get.back(),
                      onConfirm: onDelete,
                    );
                  },
                  icon: Icons.delete_outline,
                  isIcon: true,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
