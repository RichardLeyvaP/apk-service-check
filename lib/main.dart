// ignore_for_file: unused_element, depend_on_referenced_packages

import 'package:apk_service_check/myApp.dart';
import 'package:apk_service_check/providers.dart';
import 'package:apk_service_check/util/util_class.dart';
// import 'package:apk_service_check/views/env.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:open_file/open_file.dart';
// import 'package:get/get.dart';

void main() async {
  //initializeDateFormatting('es_ES', null).then((_) {
  initializeDateFormatting('pt_BR', null).then((_) async {
    WidgetsFlutterBinding.ensureInitialized();
    // Cargar las traducciones iniciales (en este caso, inglés)
    await TranslationManager.loadDefaultTranslations();
    // Cargar las traducciones antes de iniciar la aplicación
    //await _requestPermissions();
    runApp(
      MultiProvider(
        providers:
            providers, //esto es para la autenticacion por la huella dactilar
        child: Myapp(),
      ),
    );
  });
}
