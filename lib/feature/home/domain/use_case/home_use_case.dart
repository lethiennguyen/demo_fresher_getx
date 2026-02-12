import 'dart:async';

import 'package:demo_fresher_getx/feature/home/domain/repositories/home_repository.dart';

import '../../../../core/base/base.src.dart';
import '../domain.src.dart';

class HomeUseCase {
  final ListProductItemUseCase listProductItemUseCase;
  final CategoriesUseCase categoriesUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  HomeUseCase(this.listProductItemUseCase, this.categoriesUseCase,
      this.deleteProductUseCase);
}

class ListProductItemUseCase
    extends UseCase<ListProductRequestEntity, List<ProductEntity>?> {
  HomeRepository homeRepository;
  ListProductItemUseCase(this.homeRepository);
  @override
  FutureOr<List<ProductEntity>?> execute(ListProductRequestEntity input) async {
    final result = await homeRepository.lisProductItem(input);
    return result.data;
  }
}

class CategoriesUseCase extends NoInputUseCase<List<CategoriesEntity>> {
  HomeRepository homeRepository;
  CategoriesUseCase(this.homeRepository);

  @override
  FutureOr<List<CategoriesEntity>> execute() async {
    final result = await homeRepository.categories();
    return result.data!;
  }
}

class DeleteProductUseCase extends UseCase<DeleteProductEntity, ApiResponse<bool>> {
  HomeRepository homeRepository;
  DeleteProductUseCase(this.homeRepository);
  @override
  FutureOr<ApiResponse<bool>> execute(DeleteProductEntity input) async {
    final result = await homeRepository.deleteProduct(input);
    return result;
  }
}
