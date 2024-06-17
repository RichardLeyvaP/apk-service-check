import 'package:apk_service_check/Controllers/login.controller.dart';
import 'package:apk_service_check/util/util_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class HomePricipal extends StatefulWidget {
  HomePricipal({super.key});

  @override
  State<HomePricipal> createState() => _HomePricipalState();
}

class _HomePricipalState extends State<HomePricipal> {
  final LoginController cLogin = Get.find<LoginController>();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //  cLogin.toggleTheme();
      // Aquí puedes poner la lógica que necesitas ejecutar después de que el widget haya sido renderizado
      print("Widget renderizado completamente");
    });
  }

  @override
  Widget build(BuildContext context) {
    print('esto devuelve Get.isDarkMode:-1  :${Get.isDarkMode}');
    return Scaffold(
      body: Column(
        children: [
          GetBuilder<LoginController>(builder: (controll) {
            return Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 360,
                    left: -70,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.purple, Colors.lightBlue],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Stack(
                          children: [
                            Positioned(
                              top: -70,
                              right: -75,
                              child: Container(
                                width: 220,
                                height: 220,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color.fromARGB(255, 19, 61, 30),
                                      Color.fromARGB(255, 138, 240, 177),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 30,
                              right: 15,
                              child: InkWell(
                                  onTap: () {
                                    cLogin.toggleTheme();
                                    print(
                                        'esto devuelve Get.isDarkMode:2-${Get.isDarkMode}');
                                  },
                                  child: const CircleAvatar(
                                    child: Icon(
                                      Icons.brightness_medium,
                                      size: 30,
                                    ),
                                  )),
                            ),
                            Positioned(
                              top: 30,
                              right: 80,
                              child: InkWell(
                                  onTap: () {
                                    cLogin.setQrReader(true);
                                    Get.toNamed(
                                      '/QRViewExample',
                                    );
                                  },
                                  child: const CircleAvatar(
                                    child: Icon(
                                      Icons.qr_code,
                                      size: 30,
                                    ),
                                  )),
                            ),
                            Positioned(
                              top: 30,
                              right: 145,
                              child: LanguageSelector(),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(80),
                                          child: Image.network(
                                            'https://th.bing.com/th/id/OIP.dkGMi3fxsO7WBxzYXyFWKgAAAA?rs=1&pid=ImgDetMain',
                                            width: 130,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        TranslationManager.translate('title'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const Text(
                                        'Mariela Laos Zamora',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'Ing. Informática',
                                        style: TextStyle(
                                          color: cLogin.isDarkMode.value
                                              ? const Color.fromARGB(
                                                  164, 255, 255, 255)
                                              : Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          cLogin.alertDialog(
                                              '¿Quieres salir de la aplicación?',
                                              'Cancelar',
                                              '',
                                              'Salir',
                                              '/LoginFormPage');
                                          // Acción para cerrar la cuenta
                                        },
                                        child: Text(
                                            TranslationManager.translate(
                                                'closeAccount')),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 50, // Altura del Stack
                          ),
                        ],
                      ),
                      Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                color: cLogin.isDarkMode.value
                                    ? const Color.fromARGB(255, 87, 86, 86)
                                    : const Color.fromARGB(255, 81, 89,
                                        202) // Ajusta el valor de opacidad según tus necesidades
                                ),
                          )),
                    ],
                  ),
                  Positioned(
                    top: 420,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildCard(Icons.home,
                                TranslationManager.translate('cartName')),
                            buildCard(Icons.search,
                                TranslationManager.translate('cartSearch')),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () async {
                                  // controll.getIsLoading(true);
                                  Get.dialog(
                                    Center(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircularProgressIndicator(
                                                // color: Color(0xFFFDAE2A),
                                                ),
                                            SizedBox(height: 16),
                                            Text(
                                                TranslationManager.translate(
                                                    'loadTitle'),
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    barrierDismissible: false,
                                  ); //Get.back();
                                  Future.delayed(const Duration(seconds: 1),
                                      () async {
                                    // Espera a que la navegación a la nueva página se complete
                                    cLogin.setQrReader(false);
                                    await Get.toNamed('/PagePdf');
                                    // Una vez que la navegación está completa, cierra el diálogo de carga
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: buildCard(Icons.picture_as_pdf,
                                    TranslationManager.translate('cartPdf'))),
                            buildCard(Icons.settings,
                                TranslationManager.translate('cartOpction')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   // Ajusta el color según tus necesidades
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.show_chart),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: '',
      //     ),
      //   ],
      // ),
    );
  }

  Widget buildCard(IconData icon, String labelText) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: cLogin.isDarkMode.value
                ? Color.fromARGB(255, 35, 35, 36)
                : Color.fromARGB(155, 172, 176, 233)),
        width: 170,
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              child: Icon(
                icon,
                size: 35,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              labelText,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
