// ignore_for_file: depend_on_referenced_packages

import 'package:apk_service_check/get_connect/repository/user.repository.dart';
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
