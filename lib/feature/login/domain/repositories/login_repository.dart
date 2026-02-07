import 'package:demo_fresher_getx/core/base/base.src.dart';
import 'package:demo_fresher_getx/feature/login/domain/domain.src.dart';

abstract class LoginRepository {
  Future<ApiResponse<LoginDataEntity?>> login(LoginRequestEntity entity);
}
