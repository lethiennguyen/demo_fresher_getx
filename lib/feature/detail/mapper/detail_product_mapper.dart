import '../../../core/base/base.src.dart';
import '../data/data.src.dart';
import '../domain/domain.src.dart';
import 'mapper.src.dart';

class DetailProductMapper {
  ProductDataMapper productDataMapper;
  DetailProductMapper(this.productDataMapper);
}

class ProductDataMapper
    extends BaseDataMapper<ProductResponse, ProductRequestEntity>
    with DataMapperMixin {
  @override
  ProductRequestEntity mapToEntity(ProductResponse? data) {
    return ProductRequestEntity(
      id: data?.id ?? 0,
      name: data?.name ?? '',
      code: data?.code ?? '',
      price: data?.price ?? 0.0,
      stock: data?.stock ?? 0,
      categoryId: data?.categoryId ?? 0,
      description: data?.description ?? '',
      image: data?.image ?? '',
    );
  }

  @override
  ProductResponse mapToData(ProductRequestEntity entity) {
    return ProductResponse(
      id: entity.id,
      name: entity.name,
      code: entity.code,
      price: entity.price,
      stock: entity.stock,
      categoryId: entity.categoryId,
      description: entity.description,
      image: entity.image,
    );
  }
}
