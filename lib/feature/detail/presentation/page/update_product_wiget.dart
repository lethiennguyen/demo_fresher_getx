part of 'detail_product_page.dart';

Widget _buildBody(DetailProductController controller) {
  return Column(
    children: [
      buildImage(controller),
      sdsSBHeight16,
      buildNameProduct(controller),
      sdsSBHeight16,
      buildCodeProduct(controller),
      sdsSBHeight16,
      buildPriceProduct(controller),
      sdsSBHeight16,
      buildStockProduct(controller),
      sdsSBHeight16,
      buildCategoryProduct(controller),
    ],
  ).paddingAll(AppDimens.padding16);
}

Widget buildImagePicker(DetailProductController controller) {
  return DottedBorder(
    color: Colors.grey,
    strokeWidth: 1,
    dashPattern: const [6, 4],
    borderType: BorderType.RRect,
    radius: const Radius.circular(12),
    child: Container(
        width: double.infinity,
        height: 150,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              child: Icon(Icons.image, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              "Add photos",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )),
  );
}

Widget buildImage() {
  return Container(
    width: double.infinity,
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildImagePicker(Get.find()),
      ],
    ),
  );
}

Widget buildNameProduct(DetailProductController controller) {
  return SDSInputWithLabel.buildInputData(
    validator: null,
    heightInput: AppDimens.height45,
    textEditingController: controller.inputNameCtrl,
    currentNode: controller.fcsName,
    hintText: "Tên sản phẩm",
    title: "Tên sản phẩm",
    borderRadius: AppDimens.borderRadiusBig,
    paddingBottom: 0,
    isValidate: false,
    isValidateText: false,
    onChanged: (_) {},
  ).paddingSymmetric(vertical: AppDimens.padding2);
}

Widget buildCodeProduct(DetailProductController controller) {
  return SDSInputWithLabel.buildInputData(
    validator: null,
    heightInput: AppDimens.height45,
    textEditingController: controller.inputCodeCtrl,
    currentNode: controller.fcsCode,
    hintText: "Mã code sản phẩm",
    title: "Mã code sản phẩm",
    borderRadius: AppDimens.borderRadiusBig,
    paddingBottom: 0,
    isValidate: false,
    isValidateText: true,
    onChanged: (_) {},
  ).paddingSymmetric(vertical: AppDimens.padding2);
}

Widget buildPriceProduct(DetailProductController controller) {
  return SDSInputWithLabel.buildInputData(
    validator: null,
    heightInput: AppDimens.height45,
    textEditingController: controller.inputPriceCtrl,
    currentNode: controller.fcsPrice,
    title: "Giá sản phẩm",
    hintText: "Giá sản phẩm",
    borderRadius: AppDimens.borderRadiusBig,
    paddingBottom: 0,
    isValidate: false,
    isValidateText: true,
    onChanged: (_) {},
  ).paddingSymmetric(vertical: AppDimens.padding2);
}

Widget buildStockProduct(DetailProductController controller) {
  return SDSInputWithLabel.buildInputData(
    validator: null,
    heightInput: AppDimens.height45,
    textEditingController: controller.inputStockCtrl,
    currentNode: controller.fcsStock,
    title: LocaleKeys.task_search_task.tr,
    hintText: LocaleKeys.task_search_task.tr,
    borderRadius: AppDimens.borderRadiusBig,
    paddingBottom: 0,
    isValidate: false,
    isValidateText: true,
    onChanged: (_) {},
  ).paddingSymmetric(vertical: AppDimens.padding2);
}

Widget buildCategoryProduct(DetailProductController controller) {
  return SDSInputWithLabel.buildInputData(
    validator: null,
    heightInput: AppDimens.height45,
    textEditingController: controller.inputCategoryCtrl,
    currentNode: controller.fcsCategory,
    title: LocaleKeys.task_search_task.tr,
    hintText: LocaleKeys.task_search_task.tr,
    borderRadius: AppDimens.borderRadiusBig,
    paddingBottom: 0,
    isValidate: false,
    isValidateText: true,
    onChanged: (_) {},
  ).paddingSymmetric(vertical: AppDimens.padding2);
}

Widget buildBottomBar(DetailProductController controller) {
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
        Spacer(),
        ButtonUtils.buildButton(
          width: 120,
          "Lưu",
          () {},
          backgroundColor: AppColors.mainColors,
          showLoading: true,
          colorText: AppColors.basicWhite,
          height: AppDimens.btnMediumTbSmall,
          borderRadius: BorderRadius.circular(AppDimens.radius12),
        ).paddingAll(AppDimens.padding16),
      ],
    ),
  );
}
