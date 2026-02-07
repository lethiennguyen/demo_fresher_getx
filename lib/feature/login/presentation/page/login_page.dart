import 'package:demo_fresher_getx/core/base/widget_base/base_get_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/core.src.dart';
import '../../../../generated/locales.g.dart';
import '../../../../lib.dart';
import '../component/text_ipnput_field.dart';
import '../controller/login_controller.dart';

part 'login_widget.dart';

class LoginPage extends BaseGetPage<LoginController> {
  LoginPage({super.key});
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: formLogin(controller),
    );
  }
}
