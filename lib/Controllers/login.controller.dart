// ignore_for_file: depend_on_referenced_packages

import 'package:apk_service_check/get_connect/repository/user.repository.dart';
import 'package:apk_service_check/views/env.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    var result = await usuarioLg.getPdf();
    /*var result = await usuarioLg.getPdf(
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
    );*/

    if (result == true) {
      print('LA API ESTA DEVOLVIENDO TODO BIEN ESTOY YA EN EL CONTROLADOR');
    } else {
      print('DEVOLVIENDO FALSE EN EL CONTROLADOR');
    }
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
