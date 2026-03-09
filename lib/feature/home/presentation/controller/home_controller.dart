import 'dart:async';

import 'package:demo_fresher_getx/core/base/base.src.dart';
import 'package:demo_fresher_getx/generated/locales.g.dart';
import 'package:demo_fresher_getx/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/core.src.dart';
import '../../../../shared/widgets/show_popup.dart';
import '../../../detail/domain/domain.src.dart';
import '../../../detail/presentation/event/event.src.dart';
import '../../domain/domain.src.dart';

class HomeController extends BaseGetxController {
  HomeUseCase useCase;

  HomeController(this.useCase);

  RxList<ProductEntity> productList = <ProductEntity>[].obs;
  final listCategory = RxList<CategoriesEntity>();
  final categorySelected = Rx<CategoriesEntity?>(null);

  TextEditingController inputSearchCtrl = TextEditingController();
  TextEditingController categoryCtrl = TextEditingController();

  Rx<FocusNode> fcsCategory = FocusNode().obs;
  Rx<FocusNode> fcsSearch = FocusNode().obs;
  Rx<bool> showFilter = false.obs;
  Rx<bool> isFilterCategory = false.obs;

  final refreshController = RefreshController();
  RxBool isLoadMore = false.obs;

  RxInt pageSize = 10.obs;
  RxInt pageIndex = 1.obs;
  final RxInt total = 0.obs;

  RxBool enablePullup = false.obs;
  RxBool isEditCategory = false.obs;
  final RxString errorCategory = ''.obs;

  Timer? _debounceTimer;

  late StreamSubscription _sub;

  @override
  void onInit() async {
    super.onInit();
    _sub = EventBusUtils().on().listen((event) {
      if (event is DeleteProductEvent) {
        onRefresh();
      }
      if (event is CreateCategoryEvent) {
        fetchCategory();
      }
    });

    fetchCategory();
    await onRefresh();
  }

  @override
  void onClose() {
    _sub.cancel();
    super.onClose();
  }

  Future<void> fetchCategory() async {
    final result = await useCase.categoriesUseCase.execute();
    if (result.isNotEmpty) {
      listCategory.assignAll(result);
    } else {
      UtilWidget.showSnackBar(
          title: LocaleKeys.notification_title.tr,
          message: "Không có danh mục");
    }
  }

  Future<void> loadDataCategory() async {
    showButtonLoading();
    await fetchCategory();
    hideButtonLoading();
  }

  Future<void> createCategory() async {
    showButtonLoading();
    try {
      final entity = CategoryRequestEntity(
        name: categoryCtrl.text.trim(),
      );
      final result = await useCase.createCategoryUseCase.execute(entity);
      if (result.data != null) {
        await fetchCategory();
        return;
      }
      UtilWidget.showSnackBar(
        title: LocaleKeys.notification_title.tr,
        message: result.message ?? "Thêm danh mục không thành công",
      );
    } catch (e) {
      UtilWidget.showSnackBar(
        title: LocaleKeys.notification_title.tr,
        message: "Thêm danh mục không thành công",
      );
    } finally {
      hideButtonLoading();
    }
  }

  Future<void> updateCategory() async {
    showButtonLoading();
    try {
      final entity = CategoryRequestEntity(
        id: categorySelected.value?.id,
        name: categoryCtrl.text.trim(),
      );
      final result = await useCase.updateCategoryUseCase.execute(entity);
      if (result.data != null) {
        await fetchCategory();
        return;
      }
      UtilWidget.showSnackBar(
        title: LocaleKeys.notification_title.tr,
        message: result.message ?? "Cập nhật danh mục không thành công",
      );
    } catch (e) {
      UtilWidget.showSnackBar(
        title: LocaleKeys.notification_title.tr,
        message: "Cập nhật danh mục không thành công",
      );
    } finally {
      hideButtonLoading();
    }
  }

  Future<void> onRefresh() async {
    showLoading();
    pageIndex = 1.obs;
    productList.clear();
    enablePullup.value = true;
    await fetchProducts();
    hideLoading();
    refreshController.refreshCompleted();
  }

  // onLoadMore
  Future<void> onLoadMore() async {
    if (!enablePullup.value) return;
    pageIndex++;
    await fetchProducts();

    refreshController.loadComplete();
  }

  Future<void> fetchProducts({int? categoryId}) async {
    final entity = ListProductRequestEntity(
      categoryId: categoryId,
      keyword: inputSearchCtrl.text,
      page: pageIndex.value,
      pageSize: pageSize.value,
    );
    final response = await useCase.listProductItemUseCase.execute(entity);
    if (response != null) {
      if (pageSize.value == 1) {
        productList.clear();
        total.value = response.length;
      }
      productList.addAll(response);

      /// tự tính total
      total.value += response.length;

      /// còn load nữa không?
      final hasMore = response.length == pageSize.value;

      enablePullup.value = hasMore;

      if (!hasMore) {
        enablePullup.value = false;
        refreshController.loadNoData();
      }
    }
  }

  void editCategory() {
    isEditCategory.value = !isEditCategory.value;
    errorCategory.value = '';
  }

  void showDialogUpdateCategory() {
    if (categorySelected.value == null) {
      errorCategory.value = "Hãy chọn danh mục để cập nhật";
      return;
    }
    if (categorySelected.value?.name == null) {
      categoryCtrl.text = categorySelected.value?.name ?? '';
    }
    ShowPopup.showDiaLogTextField(
      "Cập nhật danh mục",
      "Lưu",
      onConfirm: () {
        updateCategory();
        Get.back();
      },
      hintText: "Danh mục mới",
      isActiveBack: true,
      categoryCtrl,
      fcsCategory,
    );
  }

  void showDialogCreateCategory() {
    ShowPopup.showDiaLogTextField(
      "Tạo danh mục",
      "Lưu",
      onConfirm: () {
        createCategory();
        Get.back();
      },
      hintText: "Danh mục mới",
      isActiveBack: true,
      categoryCtrl,
      fcsCategory,
    );
  }

  Future<void> fillerCategory({int? categoryId}) async {
    showLoading();
    pageIndex.value = 1;
    productList.clear();
    await fetchProducts(categoryId: categoryId);
    hideLoading();
  }

  void resetFilter() {
    categorySelected.value = null;
    fillerCategory(categoryId: categorySelected.value?.id);
    showFilter.value = false;
    isFilterCategory.value = false;
  }

  Future<void> deleteProduct({int? id}) async {
    showLoading();
    try {
      final entity = DeleteProductEntity(id: id);
      final response = await useCase.deleteProductUseCase.execute(entity);
      if (response.data!) {
        UtilWidget.showSnackBar(
          title: LocaleKeys.notification_title.tr,
          message: LocaleKeys.add_tasks_delete_success.tr,
        );
        onRefresh();
      } else {
        UtilWidget.showSnackBar(
            title: LocaleKeys.notification_title.tr,
            message: response.message ?? "Xóa thất bại");
      }
    } finally {
      hideLoading();
    }
  }

  Future<void> deleteCategory() async {
    showButtonLoading();
    try {
      final entity = DeleteCategoryEntity(id: categorySelected.value?.id);
      final response = await useCase.deleteCategoryUseCase.execute(entity);
      if (response.data!) {
        UtilWidget.showSnackBar(
          title: LocaleKeys.notification_title.tr,
          message: "Xóa danh mục thành công",
        );
        await fetchCategory();
      } else {
        UtilWidget.showSnackBar(
            title: LocaleKeys.notification_title.tr,
            message: response.message ?? "Xóa thất bại");
      }
    } finally {
      hideButtonLoading();
    }
  }

  void showDialogDelete() {
    if (categorySelected.value == null) {
      errorCategory.value = "Hãy chọn danh mục để xóa";
      return;
    }
    UtilWidget.showConfirmDialog(
      title: "Xóa danh mục",
      subtitle: "Bạn có muỗn xóa không",
      typeAction: AppConst.actionFail,
      onCancel: () => Get.back(),
      onConfirm: () {
        Get.back();
        deleteCategory();
      },
    );
  }

  void logout() async {
    final result = await useCase.logoutUseCase.execute();
    if (result) {
      Get.offAllNamed(
        AppRouter.routerLogin,
      );
    }
  }

  void onSearchChanged() {
    // Hủy timer cũ nếu còn
    _debounceTimer?.cancel();
    // tạo timer mới
    _debounceTimer = Timer(
      const Duration(milliseconds: 300),
      () {
        searchTab();
      },
    );
  }

  Future<void> searchTab() async {
    showLoading();
    pageSize.value = 1;
    pageSize.value = 10;
    enablePullup.value = true;
    refreshController.resetNoData();
    await fetchProducts();
    hideLoading();
  }
}
