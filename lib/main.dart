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
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.lightBlue, Colors.purple],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -30,
                      right: -35,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(96, 0, 0, 0),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      left: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(96, 0, 0, 0),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                'https://th.bing.com/th/id/OIP.dkGMi3fxsO7WBxzYXyFWKgAAAA?rs=1&pid=ImgDetMain',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Text(
                              'Mariela Laos Zamora',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
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
            ),
            Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                    color: const Color.fromARGB(214, 0, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildCard(Icons.home),
                            buildCard(Icons.search),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildCard(Icons.favorite),
                            buildCard(Icons.settings),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
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

  Widget buildCard(IconData icon) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white.withOpacity(
              0.8), // Ajusta el valor de opacidad según tus necesidades
        ),
        width: 170,
        height: 170,
        child: Icon(icon),
      ),
    );
  }
}
