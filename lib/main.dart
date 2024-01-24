// ignore_for_file: unused_element, depend_on_referenced_packages

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
    );
  }
}

//ESTE METODO NO LO ESTOY UTIIZANDO , ESTO E SPARA SABER LAS ESPECIFICACIONE SDE CADA TELEFONO
Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  int sdkInt = build.version.sdkInt;

  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'systemFeatures': build.systemFeatures,
    'displaySizeInches':
        ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
    'displayWidthPixels': build.displayMetrics.widthPx,
    'displayWidthInches': build.displayMetrics.widthInches,
    'displayHeightPixels': build.displayMetrics.heightPx,
    'displayHeightInches': build.displayMetrics.heightInches,
    'displayXDpi': build.displayMetrics.xDpi,
    'displayYDpi': build.displayMetrics.yDpi,
    'serialNumber': build.serialNumber,
  };
}

Future<void> _requestPermissions() async {
  PermissionStatus status;

  // Obtener información sobre el dispositivo
  AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
  print("Android SDK Version222: ${androidInfo.version.release}");

  // Verificar la versión de Android
  if (int.tryParse(androidInfo.version.release)! < 13) {
    // Android SDK < 23 (antes de Android 6.0), usa Permission.storage
    status = await Permission.storage.request();
  } else {
    // Android SDK >= 23 (Android 6.0 o superior), usa Permission.manageExternalStorage
    status = await Permission.manageExternalStorage.request();
  }

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

    PermissionStatus status;

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
      savePath = "${dir!.path}/$savename";

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
        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          loading = false;
        });
        // ignore: deprecated_member_use
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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.picture_as_pdf),
            Text("Baixar PDF"),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Text("Arquivo a ser baixado: $fileurl"),
            const Divider(),
            loading == false && porcent == ''
                ? ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    onPressed: _downloadPDF,
                    child: const Text(
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
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 20, 129, 25),
                                ),
                              ),
                              child: const Text(
                                "Abrir Documento",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: Color.fromARGB(255, 20, 129, 25),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      porcent == '100'
                          ? Text(
                              "Terminei de baixar ($porcent %)",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 1, 68, 18),
                                  fontSize: 20),
                            )
                          : Text(
                              "Transferindo ($porcent %)",
                              style: const TextStyle(
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
