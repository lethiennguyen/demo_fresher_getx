import 'package:get/get.dart';
import '../../core.src.dart';
import 'get_page_mixin.dart';

abstract class BaseGetPage<T extends BaseGetxController> extends GetView<T>
    with GetPageMixin {
  BaseGetPage({super.key});
}
