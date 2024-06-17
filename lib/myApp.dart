// ignore_for_file: file_names

import 'package:apk_service_check/Controllers/login.controller.dart';
import 'package:apk_service_check/Qr/CodeQrPage.dart';
import 'package:apk_service_check/Qr/loadingPage.dart';
import 'package:apk_service_check/auth/auth_check.dart';
import 'package:apk_service_check/home_principal.dart';
import 'package:apk_service_check/pagePdf.dart';
import 'package:apk_service_check/util/util_class.dart';
import 'package:apk_service_check/views/loginFormPage.dart';
import 'package:apk_service_check/views/page404.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//todo este es el que me falta optimizar
class Myapp extends StatelessWidget {
  Myapp({super.key});
  final LoginController cLogin = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        locale: cLogin.vLocale ? TranslationManager.getCurrentLocale() : null,
        localizationsDelegates: [
          // Agrega los delegados de localización para manejar las traducciones
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: TranslationManager.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: cLogin.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/LoginFormPage',
        unknownRoute: GetPage(
          name: '/Error',
          page: () => const Page404(),
        ),
        getPages: routes,
      );
    });
  }

  List<GetPage<dynamic>> get routes {
    return [
      GetPage(
        name: '/PagePdf',
        page: () => const PagePdf(),
        binding: BindingsBuilder.put(() => LoginController()),
      ),
      GetPage(
        name: '/LoginFormPage',
        page: () => LoginFormPage(),
        binding: BindingsBuilder.put(() => LoginController()),
      ),
      GetPage(
        name: '/HomePricipal',
        page: () => HomePricipal(),
        binding: BindingsBuilder.put(() => LoginController()),
      ),
      GetPage(
        name: '/LoadingPage',
        page: () => LoadingPage(),
      ),
      GetPage(name: '/QRViewExample', page: () => const QRViewPage()),
      GetPage(name: '/AuthCheck', page: () => const AuthCheck()),
    ];
  }

  ThemeData themeDataProfessional() {
    print('themeDataProfessional');
    return ThemeData(
      appBarTheme: AppBarTheme(
        toolbarHeight: 120, // Cambia este valor según tus necesidades
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
  }
}
