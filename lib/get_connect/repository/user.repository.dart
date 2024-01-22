// ignore_for_file: depend_on_referenced_packages

import 'package:apk_service_check/views/env.dart';
import 'package:get/get.dart';

class UserRepository extends GetConnect {
  Future getUserLoggedIn(String email, String password) async {
    try {
      var url = '${Env.apiEndpoint}/login';

      final Map<String, dynamic> body = {
        'email': email,
        'password': password,
      };
      final response = await post(url, body);
      print(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final users = response.body;
        print('1dentro del code:200');
        print('final users:$users');
        if (users != null) {
          print('2dentro del code:200 y tiene usuarios');
          print(users);
          return users;
        } else {
          print(
              '3dentro del code:200 pero retorno null es porque algo dio nul , la sucursal puede ser');
          return null;
        }
      } else {
        print('4No entro al code:200 este es el codigo:${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('5Error estoy en el catch (e) y este es el error:$e');
    }
  }

  Future userLogout(String token) async {
    try {
      var url = '${Env.apiEndpoint}/logout';

      // Parámetros que deseas enviar en la solicitud POST
      /*   final Map<String, dynamic> body = {
        'email': email,
        'password': password,
      };*/

      final headers = {
        "Authorization": "Bearer $token", // Agrega el token a los encabezados
      };

      final response = await get(url, headers: headers);
      //print(response.body);
      if (response.statusCode == 200) {
        final users = response.body;
        if (users != null) {
          return users;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error:$e');
      return e;
    }
  }

  Future<bool> getPdf() async {
    // Construye la URL con los parámetros
    var url = '${Env.apiEndpoint}/pdf-apk';
    final Map<String, String> headers = {
      'Content-Type': 'application/pdf', // ajusta según tu autenticación
    };
    print(url);
    try {
      final response = await get(url, headers: headers);

      print('****************************');
      print(response);
      print(response.headers);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final response1 = response.bodyBytes;
        print('Ver cómo dar la opción de descargar el pdf');
        print(response1);
        return true;
      } else {
        print('Fallo y dio código: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error en la solicitud PDF: $e');
      return false;
    }
  }

/*
 Future<bool> getPdf(
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
    // Construye la URL con los parámetros
    var url =
        '${Env.apiEndpoint}/pdf?branchName=$valorBranchName&cityState=$valorCityState&contact=$valorContact&numberRelatorie=$valorNumberRelatorie&tag=$valorTag&direction=$valorDirection&fabricante=$valorFabricante&functionProceso=$valorFunctionProceso&aplicada25=$valorAplicada25&aplicada50=$valorAplicada50&aplicada75=$valorAplicada75&aplicada100=$valorAplicada100&instrument_padrao=$valorInstrument_padrao&certificado=$valorCertificado&service_execute=$valorService_execute&art=$valorArt&tecnico=$valorTecnico&model=$valorModel&date_aferica=$valorDate_aferica&ingenier=$valorIngenier&data=$valorData&faixa=$valorFaixa&medida=$valorMedida&fre=$valorFre&dataCalibration=$valorDataCalibration&dataNextCalibration=$valorDataNextCalibration';

    final Map<String, String> headers = {
      'Content-Type': 'application/json', // ajusta según tu autenticación
    };

    try {
      final response = await get(url, headers: headers);

      print('****************************');
      print(response);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final response1 = response.bodyBytes;
        print('Ver cómo dar la opción de descargar el pdf');
        print(response1);
        return true;
      } else {
        print('Fallo y dio código: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error en la solicitud PDF: $e');
      return false;
    }
  }

*/
}
