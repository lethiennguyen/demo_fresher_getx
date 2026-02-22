import 'dart:async';

import 'package:demo_fresher_getx/core/base/base.src.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../../lib.dart';
import '../../../home/domain/domain.src.dart';
import '../../domain/domain.src.dart';
import '../../domain/use_case/use_case.src.dart';

class DetailProductController extends BaseGetxController {
  DetailProductUseCase useCase;
  ProductEntity? productEntity;

  DetailProductController(this.useCase, this.productEntity);

  TextEditingController inputNameCtrl = TextEditingController();
  TextEditingController inputCodeCtrl = TextEditingController();
  TextEditingController inputPriceCtrl = TextEditingController();
  TextEditingController inputStockCtrl = TextEditingController();
  TextEditingController inputCategoryCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  Rx<FocusNode> fcsName = FocusNode().obs;
  Rx<FocusNode> fcsCode = FocusNode().obs;
  Rx<FocusNode> fcsPrice = FocusNode().obs;
  Rx<FocusNode> fcsStock = FocusNode().obs;
  Rx<FocusNode> fcsCategory = FocusNode().obs;
  final formKey = GlobalKey<FormState>();

  final listCategory = RxList<CategoriesEntity>();
  final selectedCategory = Rx<CategoriesEntity?>(null);

  final RxBool isDetail = false.obs;

  ProductEntity? _oldProduct;

  @override
  void onInit() async {
    super.onInit();

    if (productEntity == null) {
      isDetail.value = false;
      return;
    }

    isDetail.value = true;

    // giữ snapshot để rollback nếu fail
    _oldProduct = productEntity;

    await fetchCategory();
    _fillForm();
  }

  void _fillForm({ProductEntity? productEntity}) {
    inputNameCtrl.text = productEntity?.name ?? "";
    inputCodeCtrl.text = productEntity?.code ?? "";
    inputPriceCtrl.text = productEntity?.price?.toString() ?? "";
    inputStockCtrl.text = productEntity?.stock?.toString() ?? "";
    descriptionCtrl.text = productEntity?.description ?? "";

    if (productEntity?.category != null) {
      selectedCategory.value = listCategory
          .firstWhereOrNull((e) => e.id == productEntity?.category?.id);
      inputCategoryCtrl.text = selectedCategory.value?.name ?? "";
    }
  }

  void onEditPressed() {
    if (productEntity == null) return;

    isDetail.value = false;

    inputNameCtrl.text = productEntity!.name ?? "";
    inputCodeCtrl.text = productEntity!.code ?? "";
    inputPriceCtrl.text = productEntity!.price?.toString() ?? "";
    inputStockCtrl.text = productEntity!.stock?.toString() ?? "";
    descriptionCtrl.text = productEntity!.description ?? "";

    if (productEntity!.category != null) {
      selectedCategory.value = productEntity!.category;
      inputCategoryCtrl.text = selectedCategory.value?.name ?? "";
    }
  }

  Future<void> fetchCategory() async {
    final result = await useCase.categoriesUseCase.execute();
    listCategory.assignAll(result);
  }

  Future<void> upDateProduct() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    showLoadingOverlay();
    try {
      final entity = ProductRequestEntity(
        id: productEntity?.id,
        name: inputNameCtrl.text.trim(),
        code: inputCodeCtrl.text.trim(),
        price: double.parse(inputPriceCtrl.text.replaceAll(',', '').trim()),
        stock: int.parse(inputStockCtrl.text.trim()),
        categoryId: selectedCategory.value?.id ?? 0,
        description: descriptionCtrl.text.trim(),
        image: productEntity?.image ?? '',
      );

      final result = await useCase.updateProductUseCase.execute(entity);

      if (result.data) {
        // cập nhật lại productEntity theo dữ liệu mới
        productEntity = productEntity?.copyWith(
          name: entity.name,
          code: entity.code,
          price: entity.price,
          stock: entity.stock,
          description: entity.description,
          category: selectedCategory.value,
        );

        // update snapshot
        _oldProduct = productEntity;

        UtilWidget.showSnackBar(
          title: LocaleKeys.notification_title.tr,
          message: LocaleKeys.add_tasks_update_task.tr,
        );

        isDetail.value = true;
      } else {
        // rollback form về dữ liệu cũ
        if (_oldProduct != null) {
          _fillForm(productEntity: _oldProduct!);
        }

        UtilWidget.showSnackBar(
          title: LocaleKeys.notification_title.tr,
          message: LocaleKeys.add_tasks_update_task_failed.tr,
        );
      }
    } finally {
      hideLoadingOverlay();
    }
  }

  Future<void> createProduct() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    showLoadingOverlay();
    try {
      final entity = ProductRequestEntity(
        name: inputNameCtrl.text.trim(),
        code: inputCodeCtrl.text.trim(),
        price: double.parse(inputPriceCtrl.text.replaceAll(',', '').trim()),
        stock: int.parse(inputStockCtrl.text.trim()),
        categoryId: selectedCategory.value?.id ?? 0,
        description: descriptionCtrl.text.trim(),
        image: productEntity?.image ?? '',
      );

      final result = await useCase.createProductUseCase.execute(entity);

      if (result.data) {
        // tạo ProductEntity mới từ form
        productEntity = ProductEntity(
          name: entity.name,
          code: entity.code,
          price: entity.price,
          stock: entity.stock,
          description: entity.description,
          category: selectedCategory.value,
        );

        _oldProduct = productEntity;

        isDetail.value = true;

        UtilWidget.showSnackBar(
          title: LocaleKeys.notification_title.tr,
          message: LocaleKeys.add_tasks_create_task.tr,
        );
      } else {
        UtilWidget.showSnackBar(
          title: LocaleKeys.notification_title.tr,
          message: LocaleKeys.add_tasks_create_task_failed.tr,
        );
      }
    } finally {
      hideLoadingOverlay();
    }
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Vui lòng nhập tên sản phẩm";
    }
    if (value.trim().length < 3) {
      return "Tên phải có ít nhất 3 ký tự";
    }
    return null;
  }

  String? validateCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Vui lòng nhập mã sản phẩm";
    }
    if (value.trim().length < 3) {
      return "Mã sản phẩm quá ngắn";
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Vui lòng nhập giá sản phẩm";
    }

    final price = double.tryParse(value.replaceAll(',', '').trim());
    if (price == null) {
      return "Giá phải là số hợp lệ";
    }

    if (price <= 0) {
      return "Giá phải lớn hơn 0";
    }

    return null;
  }

  String? validateStock(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Vui lòng nhập số lượng";
    }

    final stock = int.tryParse(value.trim());
    if (stock == null) {
      return "Số lượng phải là số nguyên";
    }

    if (stock < 0) {
      return "Số lượng không được âm";
    }

    return null;
  }

  String? validateCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Vui lòng nhập danh mục";
    }
    return null;
  }
}
