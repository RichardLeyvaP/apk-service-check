import 'package:apk_service_check/Controllers/login.controller.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class HomePricipal extends StatefulWidget {
  HomePricipal({super.key});

  @override
  State<HomePricipal> createState() => _HomePricipalState();
}

class _HomePricipalState extends State<HomePricipal> {
  final LoginController controllerLogin = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
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
                                  setState(() {
                                    Get.changeThemeMode(Get.isDarkMode
                                        ? ThemeMode.light
                                        : ThemeMode.dark);
                                  });
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.brightness_medium,
                                    size: 30,
                                  ),
                                )),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image.network(
                                        'https://th.bing.com/th/id/OIP.dkGMi3fxsO7WBxzYXyFWKgAAAA?rs=1&pid=ImgDetMain',
                                        width: 130,
                                        height: 130,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'Mariela Laos Zamora',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Text(
                                    'Ing. Informática',
                                    style: TextStyle(
                                      color: Color.fromARGB(164, 255, 255, 255),
                                      fontSize: 14,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      controllerLogin.alertDialog(
                                          '¿Quieres salir de la aplicación?',
                                          'Cancelar',
                                          '',
                                          'Salir',
                                          '');
                                      // Acción para cerrar la cuenta
                                    },
                                    child: const Text('Cerrar mi cuenta'),
                                  ),
                                ],
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
                              color: Get.isDarkMode
                                  ? const Color.fromARGB(255, 81, 89, 202)
                                  : const Color.fromARGB(255, 87, 86,
                                      86) // Ajusta el valor de opacidad según tus necesidades
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
                          buildCard(Icons.home, 'Home'),
                          buildCard(Icons.search, 'Buscar'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.toNamed(
                                  '/PagePdf',
                                );
                              },
                              child: buildCard(
                                  Icons.favorite, '(Favoritos(PDF))')),
                          buildCard(Icons.settings, 'Opciones'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
          color: Get.isDarkMode
              ? Color.fromARGB(155, 172, 176, 233)
              : Color.fromARGB(255, 35, 35, 36),
        ),
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
