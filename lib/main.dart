import 'package:demo_fresher_getx/core/core.src.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'generated/locales.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  AppBinding();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.nunitoSans(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: const Color(0xff5C6771),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          shape: CircleBorder(),
          backgroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      getPages: RouterPage.router,
      initialRoute: AppRouter.routerSplash,
      translationsKeys: AppTranslation.translations,
      // BẮT BUỘC
      locale: const Locale('vi', 'VN'),
      fallbackLocale: const Locale('vi', 'VN'),
    );
  }
}
