class CategoriesEntity {
  CategoriesEntity({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  final int? id;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
}
