part of 'home_page.dart';

Widget buildHomeBody(HomeController controller) {
  return Column(
    children: [
      _buildFilterStatus(controller),
      Expanded(
        child: Stack(
          children: [
            Container(
              color: const Color(
                  0xFFF5F5F5), // Màu nền xám nhạt để nổi bật Card trắng
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return _buildProductCard();
                },
              ),
            ),

            /// FILTER TRƯỢT XUỐNG
            Obx(
              () => ClipRect(
                // tránh tràn khi animate
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  child: controller.showFilter.value
                      ? FilterListProduct.fillter(() {},
                          widget: Container(
                            color: AppColors.mainColors,
                            height: 50,
                          ))
                      : const SizedBox(), // height = 0
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
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
            onChanged: (_) {},
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
        IconButton(
            onPressed: () {},
            icon: Icon(
              size: AppDimens.sizeIconSpinner,
              Icons.sort_outlined,
              color: AppColors.mainColors,
            )),
      ],
    ).paddingSymmetric(horizontal: AppDimens.padding6),
  );
}

Widget buildFloatingActionButton(HomeController controller) {
  return GestureDetector(
    onTap: () {},
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

Widget _buildProductCard() {
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
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/42/336623/realme-14-xam-6-638878505488627300-750x500.jpg",
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
                        text: "dsvdsv",
                        availableStyle: StyleEnum.t16Bold,
                        maxLine: 1,
                      ),
                      sdsSBHeight4,
                      TextUtils(
                        text: "dsvdsv",
                        availableStyle: StyleEnum.t13Regular,
                        color: AppColors.grey,
                      ),
                      sdsSBHeight8,
                      TextUtils(
                        text: "dsvdsv",
                        availableStyle: StyleEnum.t16Bold,
                      ),
                      TextUtils(
                        text: "Kho: dsvdsv",
                        availableStyle: StyleEnum.t14Bold,
                      ),
                    ],
                  ),
                ),
                buildIconButton(() => Get.offAllNamed(AppRouter.routerLogin),
                    icon: Icons.delete_outline, isIcon: true)
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    ),
  );
}
