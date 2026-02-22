import 'dart:async';

import 'package:demo_fresher_getx/feature/home/domain/repositories/home_repository.dart';

import '../../../../core/base/base.src.dart';
import '../../../home/domain/domain.src.dart';
import '../../data/data.src.dart';
import '../domain.src.dart';

class DetailProductUseCase {
  CategoriesDetailUseCase categoriesUseCase;
  CreateProductUseCase createProductUseCase;
  UpdateProductUseCase updateProductUseCase;

  DetailProductUseCase(this.categoriesUseCase, this.createProductUseCase,
      this.updateProductUseCase);
}

class CategoriesDetailUseCase extends NoInputUseCase<List<CategoriesEntity>> {
  HomeRepository homeRepository;

  CategoriesDetailUseCase(this.homeRepository);

  @override
  FutureOr<List<CategoriesEntity>> execute() async {
    final result = await homeRepository.categories();
    return result.data!;
  }
}

class CreateProductUseCase extends UseCase<ProductRequestEntity, ApiResponse> {
  DetailProductRepository repository;

  CreateProductUseCase(this.repository);

  @override
  FutureOr<ApiResponse> execute(ProductRequestEntity input) async {
    final result = await repository.create(input);
    return result.data!;
  }
}

class UpdateProductUseCase extends UseCase<ProductRequestEntity, ApiResponse> {
  DetailProductRepository repository;

  UpdateProductUseCase(this.repository);

  @override
  FutureOr<ApiResponse> execute(ProductRequestEntity input) async {
    final result = await repository.updateProject(input);
    return result.data!;
  }
}
