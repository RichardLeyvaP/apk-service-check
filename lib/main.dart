import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 36, 35, 35),
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
                                      Color.fromARGB(255, 11, 70, 231),
                                      Color.fromARGB(255, 138, 199, 240),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 70,
                                      backgroundColor:
                                          Color.fromARGB(159, 127, 171, 238),
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
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Text(
                                      'Ing. Informática',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(164, 255, 255, 255),
                                        fontSize: 14,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Acción para cerrar la cuenta
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    255, 87, 86, 86)),
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                30.0), // Ajusta el valor según tus necesidades
                                          ),
                                        ),
                                      ),
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
                            color: Colors.transparent, // Color transparente
                          ),
                        ],
                      ),
                      Expanded(
                          flex: 4,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: Color.fromARGB(255, 87, 86,
                                  86), // Ajusta el valor de opacidad según tus necesidades
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
                            buildCard(Icons.favorite, 'Favoritos'),
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
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:
              Colors.lightBlue, // Ajusta el color según tus necesidades
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Color.fromARGB(255, 20, 37, 68)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart,
                  color: Color.fromARGB(255, 20, 37, 68)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add, color: Color.fromARGB(255, 20, 37, 68)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(Icons.settings, color: Color.fromARGB(255, 20, 37, 68)),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(IconData icon, String labelText) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromARGB(255, 48, 47,
              47), // Ajusta el valor de opacidad según tus necesidades
        ),
        width: 170,
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 87, 86, 86),
              radius: 30,
              child: Icon(
                icon,
                color: Colors.lightBlue,
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
