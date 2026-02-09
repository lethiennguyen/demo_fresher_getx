import 'package:demo_fresher_getx/core/base/base.src.dart';
import 'package:demo_fresher_getx/feature/home/domain/entities/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends BaseGetxController {
  RxList<ProductEntity> productList = <ProductEntity>[].obs;

  TextEditingController inputSearchCtrl = TextEditingController();
  Rx<FocusNode> fcsSearch = FocusNode().obs;
  Rx<bool> showFilter = false.obs;

  void fetchProducts() async {
    try {
      showLoading();

      // Giả lập độ trễ mạng
      await Future.delayed(const Duration(milliseconds: 500));

      // Dữ liệu Fake dựa trên JSON của bạn
      final List<Map<String, dynamic>> fakeData = [
        {
          "id": 1,
          "status": 1,
          "name": "Updated Product Name",
          "code": "EX-100-UPDATED",
          "price": 1.99,
          "stock": 100,
          "image": "https://picsum.photos/200/200?random=1",
          "description": "Updated description for the product.",
        },
      ];

      // Map dữ liệu vào Model
      final List<ProductEntity> mappedData = fakeData.map((json) {
        return ProductEntity(
          id: json['id'],
          name: json['name'],
          code: json['code'],
          price:
              (json['price'] as num).toDouble(), // Ép kiểu an toàn cho double
          stock: json['stock'],
          status: json['status'],
          image: json['image'],
          description: json['description'],
        );
      }).toList();

      productList.assignAll(mappedData);
    } catch (e) {
      print("Lỗi load dữ liệu: $e");
    } finally {
      hideLoading();
    }
  }
}
