import 'package:dio/dio.dart';
//import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:get/get.dart';

//todo hay que poner esta dependencia
// downloads_path_provider_28: ^0.1.2

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
    );
  }
}

Future<void> _requestPermissions() async {
  final status = await Permission.manageExternalStorage.request();
  if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
    print("Please allow storage permission to download files");
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  String porcent = '';
  String fileurl =
      "https://ortografia.com.es/wp-content/uploads/2018/02/EnsayoTerro.pdf";
  String savePath = '';

  @override
  void initState() {
    super.initState();
  }

  _downloadPDF() async {
    setState(() {
      loading = true;
    });

    final status = await Permission.manageExternalStorage.request();
    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      print("Please allow storage permission to download files");
    } else if (status.isGranted) {
      //todo esto tuve que comentarlo
      /* var dir = await DownloadsPathProvider.downloadsDirectory;
      String savename = "file.pdf";
      savePath = dir!.path + "/$savename";*/

      try {
        await Dio().download(fileurl, savePath,
            onReceiveProgress: (received, total) async {
          print(total);
          print(received);
          if (total != -1) {
            double progress = (received / total * 100);
            print("Progress: $progress%");
            print((received / total * 100).toStringAsFixed(0) + "%");
            setState(() {
              porcent = progress.toStringAsFixed(0);
            });
            if (porcent == '100') {
              Get.snackbar(
                'Mensagem',
                'Arquivo A baixado com êxito!',
                duration: const Duration(milliseconds: 3000),
              );
            }
          }
        });

        print("File is saved to download folder.");
        await Future.delayed(Duration(seconds: 3));
        setState(() {
          loading = false;
        });
      } on DioError catch (e) {
        print(e.message);
        Get.snackbar(
          'Error',
          'Error al descargar el archivo',
          duration: const Duration(milliseconds: 2500),
        );
      }
    } else {
      print("No permission to read and write.");
      Get.snackbar(
        'Error',
        'Permission Denied !!',
        duration: const Duration(milliseconds: 2500),
      );
    }
  }

  _openPDF() {
    setState(() {
      porcent = '';
    });
    print('Ruta del documento que va abrir:$savePath');
    OpenFile.open(savePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.picture_as_pdf),
            Text("Baixar PDF"),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Text("Arquivo a ser baixado: $fileurl"),
            Divider(),
            loading == false && porcent == ''
                ? ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    onPressed: _downloadPDF,
                    child: Text(
                      "Baixar",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      porcent == '100'
                          ? ElevatedButton(
                              onPressed: _openPDF,
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 20, 129, 25),
                                ),
                              ),
                              child: Text(
                                "Abrir Documento",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : CircularProgressIndicator(
                              color: Color.fromARGB(255, 20, 129, 25),
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      porcent == '100'
                          ? Text(
                              "Terminei de baixar ($porcent %)",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 68, 18),
                                  fontSize: 20),
                            )
                          : Text(
                              "Transferindo ($porcent %)",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 68, 18),
                                  fontSize: 20),
                            )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
