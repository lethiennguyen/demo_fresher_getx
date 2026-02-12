import 'mapper.src.dart';

class HomeMapper {
  final ListProductRequestMapper listProductRequestMapper;
  final CategoryMapper categoryMapper;
  final ProductMapper productMapper;
  final CategoriesDataMapper categoriesDataMapper;
  final DeleteProductsMapper deleteProductsMapper;

  HomeMapper(this.listProductRequestMapper, this.categoryMapper,
      this.productMapper, this.categoriesDataMapper, this.deleteProductsMapper);
}
