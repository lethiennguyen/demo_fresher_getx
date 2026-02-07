import 'package:demo_fresher_getx/shared/shares.src.dart';
import 'package:get/get.dart';

/// - Service locator for GetX
/// - Shortcut to find dependencies in GetX
S sl<S>({String? tag}) => Get.find<S>(tag: tag);

/// - Service locator for GetX with factory
/// - Shortcut to find dependencies in GetX with factory
S slf<S>({String? tag}) => Get.findFactory<S>();
