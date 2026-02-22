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
  return FilterListProduct.fillter(
    title: "Danh mục",
    onCancel: () {
      controller.categorySelected.value = null;
      controller.fillerCategory();
      controller.showFilter.value = false;
    },
    onConfirm: () {
      controller.fillerCategory();
      controller.showFilter.value = false;
    },
    widget: Obx(() {
      return SingleChildScrollView(
        child: Wrap(
          spacing: 13,
          runSpacing: 13,
          children: controller.listCategory.map((item) {
            final selected = controller.categorySelected.value?.id == item.id;
            return GestureDetector(
              onTap: () {
                if (controller.categorySelected.value?.id == item.id) {
                  controller.categorySelected.value = null; // bỏ chọn
                } else {
                  controller.categorySelected.value = item;
                }
              },
              child: Container(
                height: AppDimens.height35,
                width: AppDimens.sizeIconBig,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: selected
                          ? AppColors.mainColors
                          : AppColors.bgKeyBoardbtn,
                      width: 0.5),
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
          }).toList(),
        ),
      );
    }),
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
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              entity.image!,
              width: 80,
              height: 80,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
                child:
                    const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
          ),
          sdsSBWidth12,

          // 2. Thông tin chi tiết
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextUtils(
                        text: entity.name ?? '',
                        availableStyle: StyleEnum.t16Bold,
                        maxLine: 1,
                      ),
                      sdsSBHeight4,
                      TextUtils(
                        text: entity.description ?? '',
                        availableStyle: StyleEnum.t13Regular,
                        color: AppColors.grey,
                      ),
                      sdsSBHeight8,
                      TextUtils(
                        text: entity.price.toString(),
                        availableStyle: StyleEnum.t16Bold,
                      ),
                      TextUtils(
                        text: entity.stock.toString(),
                        availableStyle: StyleEnum.t14Bold,
                      ),
                    ],
                  ),
                ),
                buildIconButton(() {
                  UtilWidget.showConfirmDialog(
                    title: LocaleKeys.add_tasks_delete_task.tr,
                    subtitle: LocaleKeys.add_tasks_confirm_delete_task.tr,
                    typeAction: AppConst.actionNotification,
                    onCancel: () {
                      Get.back();
                    },
                    onConfirm: onDelete,
                  );
                }, icon: Icons.delete_outline, isIcon: true)
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    ),
  );
}
