import 'package:demo_fresher_getx/feature/home/data/model/list_product_response.dart';

import '../../../core/base/base.src.dart';
import '../domain/entities/product_entity.dart';

class CategoryMapper extends BaseDataMapper<Category, CategoryEntity>
    with DataMapperMixin {
  @override
  CategoryEntity mapToEntity(Category? data) {
    return CategoryEntity(
      id: data?.id,
      status: data?.status,
      createdAt: data?.createdAt,
      updatedAt: data?.updatedAt,
      name: data?.name,
    );
  }

  @override
  Category mapToData(CategoryEntity entity) {
    return Category(
      id: entity.id,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      name: entity.name,
    );
  }
}

class ProductMapper
    extends BaseDataMapper<ProductItemResponseModel, ProductEntity>
    with DataMapperMixin {
  final _categoryMapper = CategoryMapper();

  @override
  ProductEntity mapToEntity(ProductItemResponseModel? data) {
    return ProductEntity(
      id: data?.id,
      status: data?.status,
      createdAt: data?.createdAt,
      updatedAt: data?.updatedAt,
      name: data?.name,
      code: data?.code,
      price: data?.price,
      stock: data?.stock,
      category: _categoryMapper.mapToEntity(data?.category),
      description: data?.description,
      image: data?.image,
    );
  }

  @override
  ProductItemResponseModel mapToData(ProductEntity entity) {
    return ProductItemResponseModel(
      id: entity.id,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      name: entity.name,
      code: entity.code,
      price: entity.price,
      stock: entity.stock,
      category: entity.category != null
          ? _categoryMapper.mapToData(entity.category!)
          : null,
      description: entity.description,
      image: entity.image,
    );
  }
}
