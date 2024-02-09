// ignore_for_file: depend_on_referenced_packages

import 'package:apk_service_check/get_connect/repository/user.repository.dart';
import 'package:apk_service_check/views/env.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 2), () {
      isLoading = false;
      update();
    });
  }

  UserRepository usuarioLg = UserRepository();
  bool isLoading = true;
  String greeting = 'Buenos días ';
  bool obscureText = true;
  String pathPdf = '';

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    update();
  }

  Future<void> getIsLoading(bool value) async {
    isLoading = value;
    update();
  }

  void getGreeting() {
    // Obtener la hora actual
    DateTime now = DateTime.now();

    // Obtener la hora del día
    int hour = now.hour;

    // Determinar el saludo según la hora

    if (hour < 12) {
      greeting = 'Buenos días ';
    } else if (hour < 18) {
      greeting = 'Buenas tardes ';
    } else {
      greeting = 'Buenas noches ';
    }
    update();
  }

  Future<void> exportPdf(
    // Formulario 1
    valorBranchName,
    valorCityState,
    valorContact,

    // Formulario 2
    valorNumberRelatorie,
    valorTag,
    valorDirection,
    valorFabricante,
    valorFunctionProceso,
    //
    valorFaixa,
    valorMedida,
    valorFre,
    valorDataCalibration,
    valorDataNextCalibration,

    // Formulario 3
    valorAplicada25,
    valorAplicada50,
    valorAplicada75,
    valorAplicada100,

    // Formulario 4 - Izquierda
    valorInstrument_padrao,
    valorCertificado,
    valorService_execute,
    valorArt,
    valorTecnico,

    // Formulario 4 - Derecha
    valorModel,
    valorDate_aferica,
    valorIngenier,
    valorData,
  ) async {
    //llamar al repositorio
    //var result = await usuarioLg.getPdf();
    PermissionStatus status;
    String savePath2 = '';

    // Obtener información sobre el dispositivo
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    print("Android SDK Version222: ${androidInfo.version.release}");

    // Verificar la versión de Android
    if (int.tryParse(androidInfo.version.release)! < 12) {
      // Android SDK < 23 (antes de Android 6.0), usa Permission.storage
      status = await Permission.storage.request();
    } else {
      // Android SDK >= 23 (Android 6.0 o superior), usa Permission.manageExternalStorage
      status = await Permission.manageExternalStorage.request();
    }
    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      print("Please allow storage permission to download files");
    } else if (status.isGranted) {
      var dir = await getDownloadsDirectory();
      String savename = "file.pdf";
      savePath2 = "${dir!.path}/$savename";
      print('savePath2***************************************');
      print(savePath2);
    }

    var result = await usuarioLg.getPdf(
      savePath2,
      // Formulario 1
      valorBranchName,
      valorCityState,
      valorContact,

      // Formulario 2
      valorNumberRelatorie,
      valorTag,
      valorDirection,
      valorFabricante,
      valorFunctionProceso,
      //
      valorFaixa,
      valorMedida,
      valorFre,
      valorDataCalibration,
      valorDataNextCalibration,

      // Formulario 3
      valorAplicada25,
      valorAplicada50,
      valorAplicada75,
      valorAplicada100,

      // Formulario 4 - Izquierda
      valorInstrument_padrao,
      valorCertificado,
      valorService_execute,
      valorArt,
      valorTecnico,

      // Formulario 4 - Derecha
      valorModel,
      valorDate_aferica,
      valorIngenier,
      valorData,
    );

    if (result == false) {
      print('DEVOLVIENDO FALSE EN EL CONTROLADOR');
    } else {
      //AQUI RECIBO AL PDF, ALOBJETO COMPLETO
      print(
          '------------------AQUI MOSTRANDO EL RESULTADO-----------------------');
      print(result);
      print('------------------FIN-----------------------');
      pathPdf = result;
      print('pathPdf = result;');
      update();
    }
  }

//
//
  openFilePdf() {
    OpenFile.open(pathPdf);
  }

//
//

  alertDialog(String msj, String btn1Text, String btn1Route, String btn2Tex,
      String btn2Route) {
    Get.dialog(
      AlertDialog(
        title: Text(msj),
        actions: [
          TextButton(
            onPressed: () {
              if (btn1Route != '') {
                Get.toNamed(
                  btn1Route,
                );
              } else {
                Get.back(result: true);
              }
            },
            // onPressed: () =>
            //     Get.back(result: false),
            child: Text(btn1Text),
          ),
          TextButton(
            onPressed: () {
              if (btn2Route != '') {
                Get.toNamed(
                  btn2Route,
                );
              } else {
                Get.back(result: true);
              }
            },
            child: Text('Salir'),
          ),
        ],
      ),
    );
  }
}
