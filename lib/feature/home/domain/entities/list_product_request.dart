class ListProductRequestEntity {
  final int? categoryId;
  final int? keyword;
  final int? page;
  final int? pageSize;
  ListProductRequestEntity(
      {this.categoryId, this.keyword, this.page, this.pageSize});
}
