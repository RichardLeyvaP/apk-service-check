// ignore_for_file: library_private_types_in_public_api

import 'package:apk_service_check/Controllers/login.controller.dart';
import 'package:apk_service_check/views/env.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:table_calendar/table_calendar.dart';

class PagePdf extends StatefulWidget {
  const PagePdf({super.key});

  @override
  State<PagePdf> createState() => _PagePdfState();
}

final LoginController controllerLogin = Get.find<LoginController>();

//form 1
TextEditingController tFContBranchName = TextEditingController();
TextEditingController tFContCityState = TextEditingController();
TextEditingController tFContContact = TextEditingController();
//form2
TextEditingController tFContNumberRelatorie = TextEditingController();
TextEditingController tFContTag = TextEditingController();
TextEditingController tFContDirection = TextEditingController();
TextEditingController tFContFabricante = TextEditingController();
TextEditingController tFContFunctionProceso = TextEditingController();
//
TextEditingController tFContFaixa = TextEditingController();
TextEditingController tFContMedida = TextEditingController();
TextEditingController tFContFre = TextEditingController();
TextEditingController tFContDataCalibration = TextEditingController();
TextEditingController tFContDataNextCalibration = TextEditingController();

//form3
TextEditingController tFContAplicada25 = TextEditingController();
TextEditingController tFContAplicada50 = TextEditingController();
TextEditingController tFContAplicada75 = TextEditingController();
TextEditingController tFContAplicada100 = TextEditingController();
//form4
//izq
TextEditingController tFContInstrument_padrao = TextEditingController();
TextEditingController tFContCertificado = TextEditingController();
TextEditingController tFContService_execute = TextEditingController();
TextEditingController tFContArt = TextEditingController();
TextEditingController tFContTecnico = TextEditingController();
//der
TextEditingController tFContModel = TextEditingController();
TextEditingController tFContDate_aferica = TextEditingController();
TextEditingController tFContIngenier = TextEditingController();
TextEditingController tFContData = TextEditingController();

class _PagePdfState extends State<PagePdf> {
  @override
  Widget build(BuildContext context) {
    // Llama a la función después de que el widget se haya construido
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controllerLogin.getIsLoading(false);
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.brightness_medium,
                size: 20,
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Coloca aquí el código para manejar la acción de retroceder
            Get.back();
          },
        ),
        title: Center(child: Text('Service Check PDF')),
      ),
      body: const MyHomePdf(),
    );
  }
}

class MyHomePdf extends StatefulWidget {
  const MyHomePdf({super.key});

  @override
  _MyHomePdfState createState() => _MyHomePdfState();
}

class _MyHomePdfState extends State<MyHomePdf> {
  int currentStep = 0;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  //todo **********************************************************************
  //
  /*
  bool loading = false;
  String porcent = '';
  // String fileurl =      'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
  String fileurl = '${Env.apiEndpoint}/pdf-apk';
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
      print('savePath***************************************');
      print(savePath);
      Map<String, dynamic> queryParameters = {
        //
        //
        //
        //
        //
      };

      try {
        await Dio()
            .download(fileurl, savePath, queryParameters: queryParameters,
                onReceiveProgress: (received, total) async {
          print('total:$total');
          print('received:$received');

          if (total != -109) {
            // Si la longitud total es conocida, calcula el progreso en porcentaje
            double progress = (received / total * 100);
            print('received22:$received');
            print("Progress: $progress%");
            print((received / total * 100).toStringAsFixed(0) + "%");

            // Actualiza el estado para mostrar el progreso en la interfaz de usuario
            setState(() {
              porcent = progress.toStringAsFixed(0);
            });
          } else {
            // Si la longitud total no es conocida, muestra una barra de progreso animada
            // Puedes ajustar esta lógica según tus necesidades
            // En este ejemplo, simplemente incrementamos un valor para simular una animación
            /* setState(() {
              if (porcent != '100') {
                // Solo incrementa si el porcentaje no es 100
                print(porcent);
                porcent = (int.parse(porcent) + 1).toString();
              }
            });*/
          }

          // Si la descarga se completa (ya sea que la longitud total sea conocida o no),
          // puedes mostrar un mensaje de éxito
          if (received == total || total == -1) {
            Get.snackbar(
              'Mensagem',
              'Arquivo baixado com êxito!',
              duration: const Duration(milliseconds: 3000),
            );
          }
        });

        print("File is saved to download folder.");

        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          loading = false;
          porcent = '100';
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

  */
  //
  //
  //todo **********************************************************************

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controll) {
      return Scaffold(
        body: Stepper(
          currentStep: currentStep,
          onStepTapped: (step) {
            // Aquí puedes ejecutar la acción que deseas cuando se hace clic en un número de paso
            _nextStepspecify(step);
          },
          onStepContinue: () => _nextStep(),
          onStepCancel: () => _previousStep(),
          steps: [
            Step(
              content: _buildFormStep1(),
              title: const Text('DADOS DO CLIENTE'),
              isActive: currentStep == 0,
            ),
            Step(
              content: _buildFormStep2(),
              title: const Text('DADOS DO INSTRUMENTO'),
              isActive: currentStep == 1,
            ),
            Step(
              content: _buildFormStep3(),
              title: const Text('AFERICÃO/CALIBRACÃO'),
              isActive: currentStep == 2,
            ),
            Step(
              content: _buildFormStep4(),
              title: const Text('PATRÕES UTILIZADOS'),
              isActive: currentStep == 3,
            ),
            Step(
              content: _buildFormStep5(controll),
              title: const Text('CONVERTER (Final)'),
              isActive: currentStep == 4,
            ),
          ],
          type: StepperType.vertical,
        ),
      );
    });
  }

  Widget _buildFormStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField('Empresa',
            tFContBranchName), //branchName TextEditingController tFContBranchName = TextEditingController();
        _buildTextField('Cidade/Estado',
            tFContCityState), //cityState TextEditingController tFContCityState = TextEditingController();
        _buildTextField('Contato',
            tFContContact), //contact  TextEditingController tFContContact = TextEditingController();
      ],
    );
  }

  Widget _buildFormStep2() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('No Relatório',
                  tFContNumberRelatorie), //numberRelatorie TextEditingController tFContNumberRelatorie = TextEditingController();
              _buildTextField('Tag',
                  tFContTag), //tag TextEditingController tFContTag = TextEditingController();
              _buildTextField('Descricão',
                  tFContDirection), //direction TextEditingController tFContDirection = TextEditingController();
              _buildTextField('Fabricante',
                  tFContFabricante), //fabricante TextEditingController tFContFabricante = TextEditingController();
              _buildTextField('Funcão no Proceso',
                  tFContFunctionProceso), //functionProceso TextEditingController tFContFunctionProceso = TextEditingController();
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Faixa de Calibracão',
                  tFContFaixa), //faixa TextEditingController tFContFaixa = TextEditingController();
              _buildTextField('Variável Medida',
                  tFContMedida), //medida TextEditingController tFContMedida = TextEditingController();
              _buildTextField('F.R.E',
                  tFContFre), //fre TextEditingController tFContFre= TextEditingController();

              _buildTextFieldCalendar('Data Calibracão',
                  tFContDataCalibration), //dataCalibration TextEditingController tFContDataCalibration = TextEditingController();
              _buildTextFieldCalendar('Data Prox. Calibracão',
                  tFContDataNextCalibration), //dataNextCalibration TextEditingController tFContDataNextCalibration = TextEditingController();
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField('aplicada25',
            tFContAplicada25), //aplicada25 TextEditingController tFContAplicada25 = TextEditingController();
        _buildTextField('aplicada50',
            tFContAplicada50), //aplicada50 TextEditingController tFContAplicada50 = TextEditingController();
        _buildTextField('aplicada75',
            tFContAplicada75), //aplicada75 TextEditingController tFContAplicada75 = TextEditingController();
        _buildTextField('aplicada100',
            tFContAplicada100), //aplicada100 TextEditingController tFContAplicada100 = TextEditingController();
      ],
    );
  }

  Widget _buildFormStep4() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Instrumento Patrão',
                  tFContInstrument_padrao), //instrument_padrao TextEditingController tFContInstrument_padrao = TextEditingController();
              _buildTextField('Certificado',
                  tFContCertificado), //certificado TextEditingController tFContCertificado = TextEditingController();
              _buildTextField('Servicos Executados',
                  tFContService_execute), //service_execute TextEditingController tFContService_execute = TextEditingController();
              _buildTextField('ART',
                  tFContArt), //art TextEditingController tFContArt = TextEditingController();
              _buildTextField('Técnico',
                  tFContTecnico), //tecnico TextEditingController tFContTecnico = TextEditingController();
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Modelo',
                  tFContModel), //model TextEditingController tFContModel = TextEditingController();
              _buildTextFieldCalendar('Data afericão',
                  tFContDate_aferica), //date_aferica TextEditingController tFContDate_aferica = TextEditingController();
              _buildTextField('Enegenheiro',
                  tFContIngenier), //ingenier TextEditingController tFContIngenier = TextEditingController();
              _buildTextFieldCalendar('Data',
                  tFContData), //data TextEditingController tFContData = TextEditingController();
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormStep5(LoginController controll) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Add your fields for Step 4 here
        const ElevatedButton(
          onPressed: null,
          child: Text('Salvar no banco de dados'),
        ),
        ElevatedButton(
          onPressed: () => _generatePdf(),
          child: Text('Gerar PDF'),
        ),
        ElevatedButton(
          onPressed: controll.pathPdf != '' ? controll.openFilePdf() : null,
          child: const Text(
            "Abrir Documento",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _buildTextField(String labelText, TextEditingController tEcontroller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: tEcontroller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }

  Widget _buildTextFieldCalendar(
      String labelText, TextEditingController tEcontroller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        readOnly: true,
        controller: tEcontroller,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: Icon(Icons.calendar_today),
        ),
        onTap: () {
          _showCalendarModal(context, tEcontroller);
        },
      ),
    );
  }

  Future<void> _showCalendarModal(
      BuildContext context, TextEditingController tController) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 400,
              child: Column(
                children: [
                  TableCalendar(
                    //locale: 'es_ES', // Establece el idioma en español
                    locale: 'pt_BR', // Establece el idioma en español
                    calendarFormat: _calendarFormat,
                    focusedDay: _focusedDay,
                    firstDay: DateTime(2023, 1, 1),
                    lastDay: DateTime(2025, 12, 31),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        String formattedDate = DateFormat('yyyy-MM-dd')
                            .format(selectedDay); // Formatear la fecha
                        tController.text =
                            formattedDate; // Asignar la fecha formateada al TextField
                        print('_selectedDay:$_selectedDay');
                        print('_focusedDay:$_focusedDay');
                        Navigator.of(context).pop();
                      });
                    },
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible:
                          false, // Oculta el botón de cambiar el formato (mes/semana/día)
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _nextStep() {
    if (currentStep < 4) {
      setState(() {
        currentStep++;
      });
    }
  }

  void _nextStepspecify(int number) {
    setState(() {
      currentStep = number;
    });
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _generatePdf() {
    //llamra aqui el controlador que llama la api
    // Implement PDF generation logic here
    // Formulario 1
    String valorBranchName = tFContBranchName.text;
    String valorCityState = tFContCityState.text;
    String valorContact = tFContContact.text;

// Formulario 2
    String valorNumberRelatorie = tFContNumberRelatorie.text;
    String valorTag = tFContTag.text;
    String valorDirection = tFContDirection.text;
    String valorFabricante = tFContFabricante.text;
    String valorFunctionProceso = tFContFunctionProceso.text;

    //
    String valorFaixa = tFContFaixa.text;
    String valorMedida = tFContMedida.text;
    String valorFre = tFContFre.text;
    String valorDataCalibration = tFContDataCalibration.text;
    String valorDataNextCalibration = tFContDataNextCalibration.text;

// Formulario 3
    int valorAplicada25 = int.tryParse(tFContAplicada25.text) ?? 0;
    int valorAplicada50 = int.tryParse(tFContAplicada50.text) ?? 0;
    int valorAplicada75 = int.tryParse(tFContAplicada75.text) ?? 0;
    int valorAplicada100 = int.tryParse(tFContAplicada100.text) ?? 0;

// Formulario 4 - Izquierda
    String valorInstrument_padrao = tFContInstrument_padrao.text;
    String valorCertificado = tFContCertificado.text;
    String valorService_execute = tFContService_execute.text;
    String valorArt = tFContArt.text;
    String valorTecnico = tFContTecnico.text;

// Formulario 4 - Derecha
    String valorModel = tFContModel.text;
    String valorDate_aferica = tFContDate_aferica.text;
    String valorIngenier = tFContIngenier.text;
    String valorData = tFContData.text;
    print('entre a la funcion void _generatePdf() de la vista');
    // Llamada al método exportPdf con todas las variables
    print(valorBranchName);
    print(valorCityState);
    print(valorContact);
    print('LLAMANDO AL CONTROLADOR controllerLogin.exportPdf');
    controllerLogin.exportPdf(
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
  }

  void _cancel() {
    // Implement cancel logic here
  }
}
