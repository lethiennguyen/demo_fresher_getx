import 'dart:async';

import 'package:demo_fresher_getx/core/base/base.src.dart';
import 'package:demo_fresher_getx/generated/locales.g.dart';
import 'package:demo_fresher_getx/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../domain/domain.src.dart';

class HomeController extends BaseGetxController {
  HomeUseCase useCase;

  HomeController(this.useCase);

  RxList<ProductEntity> productList = <ProductEntity>[].obs;
  final listCategory = RxList<CategoriesEntity>();
  final categorySelected = Rx<CategoriesEntity?>(null);

  TextEditingController inputSearchCtrl = TextEditingController();
  Rx<FocusNode> fcsSearch = FocusNode().obs;
  Rx<bool> showFilter = false.obs;

  final refreshController = RefreshController();
  RxBool isLoadMore = false.obs;

  RxInt pageSize = 10.obs;
  RxInt pageIndex = 1.obs;
  final RxInt total = 0.obs;
  RxBool enablePullup = false.obs;
  Timer? _debounceTimer;

  @override
  void onInit() async {
    super.onInit();
    fetchCategory();
    await onRefresh();
  }

  Future<void> fetchCategory() async {
    final result = await useCase.categoriesUseCase.execute();
    listCategory.assignAll(result);
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

  Future<void> fetchProducts() async {
    final entity = ListProductRequestEntity(
      categoryId: categorySelected.value?.id,
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

  Future<void> fillerCategory() async {
    showLoading();
    pageIndex.value = 1;
    productList.clear();
    await fetchProducts();
    hideLoading();
  }

  Future<void> deleteProduct({int? id}) async {
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
          title: LocaleKeys.notification_title.tr, message: "Xóa thất bại");
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
    pageIndex.value = 1;
    productList.clear();
    enablePullup.value = true;
    refreshController.resetNoData();
    await fetchProducts();
    hideLoading();
  }
}
