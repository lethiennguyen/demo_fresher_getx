import 'package:demo_fresher_getx/feature/detail/presentation/bindings/detail_product_binding.dart';
import 'package:demo_fresher_getx/feature/home/presentation/bindings/home_binding.dart';
import 'package:demo_fresher_getx/feature/home/presentation/page/home_page.dart';
import 'package:demo_fresher_getx/feature/login/presentation/bindings/binding.src.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../feature/app/app_page.dart';
import '../../feature/app/controller/binding.dart';
import '../../feature/detail/presentation/page/detail_product_page.dart';
import '../../feature/login/presentation/page/login_page.dart';
import 'app_router.dart';

class RouterPage {
  static var router = [
    GetPage(
      name: AppRouter.routerSplash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: AppRouter.routerLogin,
        page: () => LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppRouter.routerHome,
        page: () => HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: AppRouter.routerDetail,
        page: () => DetailProductPage(),
        binding: DetailProductBinding()),
  ];
}
