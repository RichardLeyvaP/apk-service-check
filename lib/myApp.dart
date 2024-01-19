// ignore_for_file: file_names

import 'package:apk_service_check/Controllers/login.controller.dart';
import 'package:apk_service_check/home_principal.dart';
import 'package:apk_service_check/pagePdf.dart';
import 'package:apk_service_check/views/page404.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//todo este es el que me falta optimizar
class Myapp extends StatelessWidget {
  Myapp({super.key});
  final LoginController controllerasas = Get.put(LoginController());
  final Color colorPrimario = const Color(0xFFF18254); // Color primario appBar
  final Color colorSecundario =
      const Color.fromARGB(155, 231, 232, 234); // Color secundario
  final Color colorPrimario2 =
      const Color.fromARGB(255, 26, 50, 82); // Color primario appBar
  final Color colorSecundario2 =
      const Color.fromARGB(155, 36, 86, 185); // Color secundario

  @override
  Widget build(Object context) {
    return GetBuilder<LoginController>(builder: (_) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeDataProfessional(), //es tecnico
        initialRoute: '/HomePricipal',
        //initialRoute: '/SplashPage',
        unknownRoute: GetPage(
          name: '/Error', // Nombre de la ruta de error
          page: () => const Page404(), // Página de error
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
        name: '/HomePricipal',
        page: () => HomePricipal(),
        binding: BindingsBuilder.put(() => LoginController()),
      ),
    ];
  }

  ThemeData themeDataProfessional() {
    print('themeDataProfessional');
    return ThemeData(
      appBarTheme: AppBarTheme(
        toolbarHeight: 120, // Cambia este valor según tus necesidades
        backgroundColor: colorPrimario,
      ),
      primaryColor: colorPrimario, // Color primario
      hintColor: colorSecundario,
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
  }
}
