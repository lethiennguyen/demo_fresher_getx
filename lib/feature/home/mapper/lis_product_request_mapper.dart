import '../../../shared/mappers/base/base_data_mapper.dart';
import '../data/model/list_product_request.dart';
import '../domain/entities/list_product_request.dart';

class ListProductRequestMapper
    extends BaseDataMapper<ListProductRequestModel, ListProductRequestEntity>
    with DataMapperMixin {
  @override
  ListProductRequestEntity mapToEntity(ListProductRequestModel? data) {
    return ListProductRequestEntity(
      categoryId: data?.categoryId,
      // Chuyển String sang int (nếu cần thiết theo đúng khai báo Entity của bạn)
      keyword: data?.keyword != null ? int.tryParse(data!.keyword!) : null,
      page: data?.page,
      pageSize: data?.pageSize,
    );
  }

  @override
  ListProductRequestModel mapToData(ListProductRequestEntity entity) {
    return ListProductRequestModel(
      categoryId: entity.categoryId,
      // Chuyển int từ Entity sang String để gửi lên API
      keyword: entity.keyword?.toString(),
      page: entity.page,
      pageSize: entity.pageSize,
    );
  }
}
