class ProductRequestEntity {
  final int? id;
  final String name;
  final String code;
  final double price;
  final int stock;
  final int categoryId;
  final String description;
  final String image;

  ProductRequestEntity({
    this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.stock,
    required this.categoryId,
    required this.description,
    required this.image,
  });
}
